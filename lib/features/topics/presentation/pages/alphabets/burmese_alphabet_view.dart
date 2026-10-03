// Path: alphabet/burmese_alphabet_view.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/app/service/locator.dart';
import 'package:putu_education/app/widgets/loading_widgets.dart';

import '../../../../widgets/go_button.dart';
import '../../../../widgets/item_decoration.dart';
import '../../../../widgets/my_appbar.dart';
import '../../../../widgets/my_icon.dart';
import '../../bloc/alphabet_bloc/alphabet_bloc.dart';

class MyanmarAlphabetView extends StatefulWidget {
  const MyanmarAlphabetView({super.key});

  @override
  State<MyanmarAlphabetView> createState() => _MyanmarAlphabetViewState();
}

class _MyanmarAlphabetViewState extends State<MyanmarAlphabetView> {
  final AlphabetBloc _bloc = getIt<AlphabetBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc.add(const AlphabetsRequested(subject: 'mm'));
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
    _bloc.add(AlphabetsRequested(subject: 'mm', page: page));
  }

  Future<void> _onRefresh() async {
    setState(() => _selectedIndex = 0);
    _bloc.add(
        const AlphabetsRequested(subject: 'mm', page: 1, forceRefresh: true));
    await _bloc.stream
        .firstWhere((state) => state.status != AlphabetsStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: 'အက္ခရာများ',
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/light_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: BlocBuilder<AlphabetBloc, AlphabetState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state.status == AlphabetsStatus.loading &&
                    state.alphabets.isEmpty) {
                  return const Center(child: LoadingWidget(size: 32));
                }
                if (state.status == AlphabetsStatus.failure &&
                    state.alphabets.isEmpty) {
                  return GestureDetector(
                    onTap: () => _bloc.add(AlphabetsRequested(
                        subject: 'mm', page: state.currentPage)),
                    child: Center(
                      child: Text(
                        'Failed to load alphabets. Tap to retry.',
                        style: FontFamily().medium.copyWith(fontSize: 14),
                      ),
                    ),
                  );
                }

                final alphabets = state.alphabets;
                final selectedIndex = _selectedIndex.clamp(
                    0, alphabets.isEmpty ? 0 : alphabets.length - 1);
                final selected =
                    alphabets.isEmpty ? null : alphabets[selectedIndex];

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: context.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorResources.secondary,
                                border: Border.all(
                                    color: ColorResources.lightBg, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => _playAudio(selected?.audio),
                                      child: MyIcon(iconName: 'volume'),
                                    ),
                                  ).pad(right: 16, top: 16),
                                  Text(
                                    selected?.letter ?? '',
                                    style: FontFamily().semiBold.copyWith(
                                          fontSize: FontSize().sixteenFour,
                                        ),
                                  ),
                                  Text(
                                    selected?.word ?? '',
                                    style: FontFamily().semiBold.copyWith(
                                          fontSize: FontSize().twentyFour,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              alphabets.length,
                              (index) {
                                final data = alphabets[index];
                                return GestureDetector(
                                  key: ValueKey('alphabet_${data.id}'),
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
                                        data.letter ?? '',
                                        style: FontFamily().bold.copyWith(
                                              fontSize: FontSize().twenty,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ).pad(top: 20),
                      ),
                      Stack(
                        children: [
                          if (state.hasPrev)
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                  onTap: () =>
                                      _requestPage(state.currentPage - 1),
                                  child: GoButton(isNext: false),
                                )),
                          if (state.hasNext)
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () =>
                                      _requestPage(state.currentPage + 1),
                                  child: GoButton(isNext: true),
                                )),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ).pad(
                left: 10,
                right: 10,
                top: 24,
                bottom: MediaQuery.of(context).padding.bottom)),
      ),
    );
  }
}
