// Path: numbers/numbers_view.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/app/service/locator.dart';
import 'package:putu_education/app/widgets/loading_widgets.dart';
import 'package:putu_education/features/widgets/go_button.dart';
import 'package:putu_education/features/widgets/item_decoration.dart';
import 'package:putu_education/features/widgets/my_appbar.dart';

import '../../../../../app/widgets/banner_ad_widget.dart';
import '../../../../widgets/my_icon.dart';
import '../../bloc/number_bloc/number_bloc.dart';

class NumbersView extends StatefulWidget {
  const NumbersView({super.key, required this.subject, required this.title});

  final String subject;
  final String title;

  @override
  State<NumbersView> createState() => _NumbersViewState();
}

class _NumbersViewState extends State<NumbersView> {
  final NumberBloc _bloc = getIt<NumberBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc.add(NumbersRequested(subject: widget.subject));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _bloc.close();
    super.dispose();
  }

  Future<void> _playAudio(String? audioUrl) async {
    if (audioUrl == null || audioUrl.isEmpty) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(audioUrl));
  }

  void _requestPage(int page) {
    setState(() => _selectedIndex = 0);
    _bloc.add(NumbersRequested(subject: widget.subject, page: page));
  }

  Future<void> _onRefresh() async {
    setState(() => _selectedIndex = 0);
    _bloc.add(
        NumbersRequested(subject: widget.subject, page: 1, forceRefresh: true));
    await _bloc.stream
        .firstWhere((state) => state.status != NumbersStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      bottomNavigationBar: const BannerAdWidget(),
      appBar: MyAppBar(
        titleWithGoBack: widget.title,
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/light_background.png"
                  ),
                  fit: BoxFit.fill)),
          child: BlocBuilder<NumberBloc, NumberState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state.status == NumbersStatus.loading &&
                  state.numbers.isEmpty) {
                return const Center(child: LoadingWidget(size: 32));
              }
              if (state.status == NumbersStatus.failure &&
                  state.numbers.isEmpty) {
                return GestureDetector(
                  onTap: () => _bloc.add(
                      NumbersRequested(subject: widget.subject, page: state.currentPage)),
                  child: Center(
                    child: Text(
                      'Failed to load numbers. Tap to retry.',
                      style: FontFamily().medium.copyWith(fontSize: 14),
                    ),
                  ),
                );
              }

              final numbers = state.numbers;
              final selectedIndex = _selectedIndex.clamp(
                  0, numbers.isEmpty ? 0 : numbers.length - 1);
              final selected = numbers.isEmpty ? null : numbers[selectedIndex];

              return Stack(
                fit: StackFit.loose,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: context.height*0.25,
                              // constraints: BoxConstraints(minHeight: context.height/4),
                              width: context.width,
                              decoration: BoxDecoration(
                                color: ColorResources.secondary,
                                border: Border.all(
                                    color: ColorResources.lightBg, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () =>
                                          _playAudio(selected?.audio),
                                      child: MyIcon(iconName: 'volume'),
                                    ),
                                  ).pad(right: 16, top: 16),
                                  Text(
                                    '${selected?.number ?? ''}',
                                    style: FontFamily().semiBold.copyWith(
                                        fontSize: 70),
                                  ),
                                  Expanded(
                                    child: Text(
                                      selected?.word ?? '',
                                      style: FontFamily().semiBold.copyWith(
                                          // fontSize: FontSize().twentyFour
                                        fontSize: 30
                                      ),
                                    ),
                                  ),
                                ],
                              )).pad(bottom: 32),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8.0, // gap between adjacent items
                            runSpacing: 8.0, // gap between lines
                            children: List.generate(
                              numbers.length,
                              (index) {
                                final data = numbers[index];
                                return GestureDetector(
                                    key: ValueKey('number_${data.id}'),
                                    onTap: () {
                                      setState(() => _selectedIndex = index);
                                      _playAudio(data.audio);
                                    },
                                    child: Container(
                                      width: context.width / 5,
                                      height: context.width / 5,
                                      decoration: index == selectedIndex
                                          ? selectedDecoration()
                                          : unselectedDecoration(),
                                      child: Center(
                                          child: Text(
                                        '${data.number ?? ''}',
                                        style: FontFamily().bold.copyWith(
                                            fontSize: FontSize().twenty),
                                      )),
                                    ));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      if (state.hasPrev)
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              onTap: () => _requestPage(state.currentPage - 1),
                              child: GoButton(isNext: false),
                            )),
                      if (state.hasNext)
                        Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () => _requestPage(state.currentPage + 1),
                              child: GoButton(isNext: true),
                            )),
                    ],
                  )
                ],
              );
            },
          ).pad(
              left: 16,
              right: 16,
              top: 24,
              bottom: MediaQuery.of(context).padding.bottom+30),
        ),
      ),
    );
  }
}
