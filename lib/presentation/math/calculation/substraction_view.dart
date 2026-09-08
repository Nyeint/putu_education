// Path: calculation/substraction_view.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/presentation/math/calculation/widgets/example_item.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';

const double _kTabBarExtent = 64;

class SubtractionView extends StatefulWidget {
  final String? locale;
  SubtractionView({super.key, required this.locale});

  @override
  State<SubtractionView> createState() => _SubtractionViewState();
}

class _SubtractionViewState extends State<SubtractionView> {
  List<int> numberList = [0, 5, 10, 15];
  int selectedNumber = 0;

  Widget tabItem(int number) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNumber = number;
        });
      },
      child: Container(
        constraints: BoxConstraints(minHeight: 48),
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: selectedNumber == number
            ? selectedTabDecoration()
            : unselectedTabDecoration(),
        child: Center(
          child: Text(
            widget.locale == 'en'
                ? '${number + 1} - ${number + 5}'
                : '${(number + 1).toString().burmese()} - ${(number + 5).toString().burmese()}',
            style: FontFamily().medium.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget textWidget(String text) {
    return Text(
      widget.locale == 'en' ? text : text.burmese(),
      style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorResources.stroke),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExampleItem(
                      context: context,
                      firstTens: '2',
                      firstOnes: '3',
                      secondTens: '5',
                      secondOnes: '6',
                      thirdTens: '7',
                      thirdOnes: '9',
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(tr('answer'), style: FontFamily().regular),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _PinnedTabBarDelegate(
            extent: _kTabBarExtent,
            child: Material(
              color: ColorResources.background,
              elevation: 4,
              shadowColor: Colors.black26,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    tabItem(numberList[0]),
                    const SizedBox(width: 10),
                    tabItem(numberList[1]),
                    const SizedBox(width: 10),
                    tabItem(numberList[2]),
                    const SizedBox(width: 10),
                    tabItem(numberList[3]),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 16, bottom: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final aBase = index + 1 + selectedNumber;
                return Container(
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.lightBg,
                  ),
                  child: Column(
                    children: List.generate(10, (index1) {
                      final b = index1;
                      return Padding(
                        padding: EdgeInsets.only(bottom: index1 < 9 ? 8 : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            textWidget(aBase.toString()),
                            Text(
                              '-',
                              style: FontFamily().medium
                                  .copyWith(fontSize: FontSize().twenty),
                            ),
                            textWidget(b.toString()),
                            Text(
                              '=',
                              style: FontFamily().medium
                                  .copyWith(fontSize: FontSize().twenty),
                            ),
                            textWidget((aBase - b).toString()),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              },
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}

class _PinnedTabBarDelegate extends SliverPersistentHeaderDelegate {
  _PinnedTabBarDelegate({
    required this.extent,
    required this.child,
  });

  final double extent;
  final Widget child;

  @override
  double get minExtent => extent;

  @override
  double get maxExtent => extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(height: extent, child: child);
  }

  @override
  bool shouldRebuild(covariant _PinnedTabBarDelegate oldDelegate) {
    return extent != oldDelegate.extent || child != oldDelegate.child;
  }
}
