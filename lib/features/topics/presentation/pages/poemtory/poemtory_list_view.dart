// Path: poem/poemtory_list_view.dart
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/app/service/locator.dart';
import 'package:putu_education/app/widgets/loading_widgets.dart';
import 'package:putu_education/features/topics/presentation/pages/poemtory/poemtory_detail.dart';
import 'package:putu_education/features/widgets/item_decoration.dart';
import 'package:putu_education/route/my_router.dart';
import '../../../../../app/widgets/banner_ad_widget.dart';
import '../../../../widgets/my_appbar.dart';
import '../../../data/model/poemtory_list_model.dart';
import '../../bloc/poemtory_bloc/poemtory_bloc.dart';

/// Shared poems/stories/songs list screen. [poemtoryType] selects which
/// content type is requested (e.g. 'poem', 'story', 'song') and is sent as
/// part of the API path; [subject] is the API's language code for the
/// content ('en' for English, 'my' for Myanmar).
class PoemToryListView extends StatefulWidget {
  final String title;
  final String poemtoryType;
  final String subject;

  const PoemToryListView(
      {super.key,
      required this.title,
      required this.poemtoryType,
      required this.subject});

  @override
  State<PoemToryListView> createState() => _PoemToryListViewState();
}

class _PoemToryListViewState extends State<PoemToryListView> {
  final PoemToryBloc _poemtoryBloc = getIt<PoemToryBloc>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _requestPoemTories();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _poemtoryBloc.close();
    super.dispose();
  }

  void _requestPoemTories() {
    _poemtoryBloc.add(PoemToriesRequested(
      poemtoryType: widget.poemtoryType,
      subject: widget.subject,
    ));
  }

  Future<void> _onRefresh() async {
    _poemtoryBloc.add(PoemToriesRefreshRequested(
      poemtoryType: widget.poemtoryType,
      subject: widget.subject,
    ));
    await _poemtoryBloc.stream.firstWhere((state) => !state.isRefreshing);
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  Future<void> _onLoading() async {
    _poemtoryBloc.add(PoemToriesLoadMoreRequested(
      poemtoryType: widget.poemtoryType,
      subject: widget.subject,
    ));
    await _poemtoryBloc.stream.firstWhere((state) => !state.isLoadingMore);
    if (_poemtoryBloc.state.hasMore) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  Widget _poemtoryItem(PoemToryData item) {
    return GestureDetector(
      // onTap: () => context.pushNamed(RouteName.poemDetail, extra: {'id': item.id}),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PoemToryDetailView(
                      data: item,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: unselectedDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                width: context.width / 3.5,
                height: context.width / 3.5,
                imageUrl: item.image ?? '',
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    border: Border.all(color: ColorResources.lightBg),
                  ),
                  child: Icon(Icons.image,
                      color: ColorResources.primary, size: context.width / 3.5),
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title ?? '',
                    style: FontFamily()
                        .semiBold
                        .copyWith(fontSize: FontSize().sixteen),
                  ),
                  SizedBox(height: 4),
                  _ExpandableText(
                    text: markdown
                        .markdownToHtml(item.description ?? '')
                        .toPlainText,
                    maxLines: 3,
                    style: FontFamily().regular.copyWith(
                          fontSize: 15,
                          color: ColorResources.itemSecondary,
                          height: 1.35,
                        ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.duration != null ? '${item.duration} mins' : '',
                        style: FontFamily().regular.copyWith(
                              color: ColorResources.subText,
                              fontSize: FontSize().fourteen,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset("assets/icons/next.svg",
                            height: 16),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Wraps [child] in a scrollable that always has enough scroll extent to
  /// be dragged, so pull-to-refresh keeps working even while the list is
  /// loading, empty, or showing a failure message.
  Widget _scrollableMessage(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 16, right: 16, top: 24),
        children: [
          SizedBox(
            height: constraints.maxHeight,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _poemtoryList(PoemToryState state) {
    if (state.status == PoemToriesStatus.loading ||
        state.status == PoemToriesStatus.initial) {
      return _scrollableMessage(Center(child: LoadingWidget(size: 32)));
    } else if (state.status == PoemToriesStatus.failure &&
        state.poemtories.isEmpty) {
      return _scrollableMessage(
        GestureDetector(
          onTap: _onRefresh,
          child: Center(
            child: Text(
              'Failed to load. Tap to retry.',
              style: FontFamily().medium.copyWith(fontSize: 14),
            ),
          ),
        ),
      );
    }

    final poemtories = state.poemtories;
    if (poemtories.isEmpty) {
      return _scrollableMessage(
        Center(
            child: Text(tr('no_data'),
                style: FontFamily().medium.copyWith(fontSize: 14))),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 16, right: 16, top: 24),
      itemCount: poemtories.length,
      itemBuilder: (context, index) => _poemtoryItem(poemtories[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        bottomNavigationBar: const BannerAdWidget(),
        appBar: MyAppBar(
          titleWithGoBack: widget.title,
          // titleWithGoBack: tr(widget.poemtoryType),
        ),
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/light_background.png",
                  ),
                  fit: BoxFit.cover)),
          child: BlocListener<PoemToryBloc, PoemToryState>(
            bloc: _poemtoryBloc,
            listener: (context, state) {
              // Background refresh/load-more failures keep the existing list
              // on screen, so surface them as a toast instead of an
              // interruptive full-screen error.
              if (state.status == PoemToriesStatus.failure &&
                  state.poemtories.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to load. Please try again.')),
                );
              }
            },
            child: BlocBuilder<PoemToryBloc, PoemToryState>(
              bloc: _poemtoryBloc,
              builder: (context, state) => SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: state.hasMore,
                header: WaterDropHeader(),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: _poemtoryList(state),
              ),
            ),
          ),
        )));
  }
}

class _ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const _ExpandableText({
    required this.text,
    required this.style,
    this.maxLines = 2,
  });

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final linkStyle = widget.style.copyWith(
      color: ColorResources.primary,
      fontWeight: FontWeight.w500,
    );

    if (_isExpanded) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(text: widget.text, style: widget.style),
            TextSpan(
              text: ' ${tr('see_less')}',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => setState(() => _isExpanded = false),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final fullPainter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: widget.maxLines,
          textDirection: ui.TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        if (!fullPainter.didExceedMaxLines) {
          return Text(widget.text, style: widget.style);
        }

        final linkText = ' ${tr('see_more')}';
        final linkPainter = TextPainter(
          text: TextSpan(text: linkText, style: linkStyle),
          textDirection: ui.TextDirection.ltr,
        )..layout();

        final cutoffPosition = fullPainter.getPositionForOffset(
          Offset(
            constraints.maxWidth - linkPainter.width,
            fullPainter.height,
          ),
        );

        final endIndex = cutoffPosition.offset.clamp(0, widget.text.length);
        final truncated = widget.text.substring(0, endIndex).trimRight();

        return
            // Text(truncated, style: widget.style,);
            RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '$truncated…', style: widget.style),
            ],
          ),
        );
      },
    );
  }
}
