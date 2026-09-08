// Path: calculation/division_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';

const double _kTabBarExtent = 64;

class DivisionView extends StatefulWidget {
  final String locale;
  DivisionView({super.key, required this.locale});

  @override
  State<DivisionView> createState() => _DivisionViewState();
}

class _DivisionViewState extends State<DivisionView> {
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
              SizedBox(height: 24),
              Container(
                width: context.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorResources.stroke),
                ),
                child: SvgPicture.asset(
                  "assets/images/division_one.svg",
                  width: context.width * 0.5,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: context.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorResources.stroke),
                ),
                child: SvgPicture.asset(
                  "assets/images/division_two.svg",
                  width: context.width * 0.6,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Divident',
                    style: FontFamily().medium
                        .copyWith(fontSize: FontSize().twenty),
                  ),
                  Text(
                    '/',
                    style: FontFamily().medium
                        .copyWith(fontSize: FontSize().twenty),
                  ),
                  Text(
                    'Divisor',
                    style: FontFamily().medium
                        .copyWith(fontSize: FontSize().twenty),
                  ),
                  Text(
                    '=',
                    style: FontFamily().medium
                        .copyWith(fontSize: FontSize().twenty),
                  ),
                  Text(
                    'Quotient',
                    style: FontFamily().medium
                        .copyWith(fontSize: FontSize().twenty),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                final dividend = index + 1 + selectedNumber;
                return Container(
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.lightBg,
                  ),
                  child: Column(
                    children: List.generate(10, (index1) {
                      final divisor = index1 + 1;
                      final quotient = dividend ~/ divisor;
                      return Padding(
                        padding: EdgeInsets.only(bottom: index1 < 9 ? 8 : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            textWidget(dividend.toString()),
                            Text(
                              '/',
                              style: FontFamily().medium
                                  .copyWith(fontSize: FontSize().twenty),
                            ),
                            textWidget(divisor.toString()),
                            Text(
                              '=',
                              style: FontFamily().medium
                                  .copyWith(fontSize: FontSize().twenty),
                            ),
                            textWidget(quotient.toString()),
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
