// Path: widgets/result_view.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';

class ResultView extends StatefulWidget {
  int score;
  Widget childWidget;
  ResultView({super.key, required this.score,  required this.childWidget});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  int get _starCount {
    // if (widget.maxScore <= 0) return 1;
    final ratio = widget.score / 10;
    if (ratio >= 0.8) return 3;
    if (ratio >= 0.5) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.32, 1],
              colors: [ColorResources.primary, ColorResources.secondary, ColorResources.background],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70,),
                      // SizedBox(height: context.width * 0.1),
                      Text('${tr('well_done')} 🎉',
                          style: FontFamily().bold.copyWith(fontSize: FontSize().twentyFour)),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              tr('your_score').toUpperCase(),
                              style: FontFamily().semiBold.copyWith(
                                  fontSize: FontSize().fourteen,
                                  color: ColorResources.primary,
                                  letterSpacing: 1.2)
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  context.locale.languageCode == 'en'
                                      ? widget.score.toString()
                                      : widget.score.toString().burmese(),
                                  style: FontFamily().bold.copyWith(
                                      fontSize: FontSize().fortyEight, color: ColorResources.primary),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4, bottom: 8),
                                  child: Text(
                                    '/10',
                                    // '/${context.locale.languageCode == 'en' ? widget.maxScore.toString() : widget.maxScore.toString().burmese()}',
                                    style: FontFamily()
                                        .semiBold
                                        .copyWith(fontSize: FontSize().twenty, color: ColorResources.subText),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) {
                                final filled = index < _starCount;
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Icon(
                                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                                    color: ColorResources.primary,
                                    size: context.width * 0.1,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 28),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(tr('review_answers'),
                                style: FontFamily()
                                    .bold
                                    .copyWith(fontSize: FontSize().eighteen, color: ColorResources.burmese)),
                            SizedBox(width: 12),
                            Expanded(child: Container(height: 2, color: ColorResources.stroke.withOpacity(0.4))),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      widget.childWidget,
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ColorResources.primaryGradient, ColorResources.primary],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: ColorResources.primary.withOpacity(0.5),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Text(tr('go_home'), style: FontFamily().bold.copyWith(fontSize: FontSize().eighteen)),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
