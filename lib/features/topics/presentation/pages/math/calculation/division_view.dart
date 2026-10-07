// Path: calculation/division_view.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../app/config/config.dart';
import '../../../../../../app/config/widget_extensions.dart';
import '../../../../../widgets/item_decoration.dart';

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

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black87),
      ),
      child: Text(text, style: FontFamily().medium.copyWith(fontSize: 22)),
    );
  }

  Widget _num(String text) {
    return Text(
      widget.locale == 'en' ? text : text.burmese(),
      style: FontFamily().medium.copyWith(fontSize: 32),
    );
  }

  Widget _line(double width, {double height = 2}) =>
      Container(width: width, height: height, color: Colors.black87);

  // Fixed-size canvas (545 x h) scaled down to fit; children placed by (left, top).
  Widget _card(double h, List<Widget> children) {
    return Container(
      width: context.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorResources.stroke),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child:
            SizedBox(width: 545, height: h, child: Stack(children: children)),
      ),
    );
  }

  Widget _at(double left, double top, Widget child) =>
      Positioned(left: left, top: top, child: child);

  // Static 10 / 2 = 5 example, as a fraction and as long division.
  Widget _divisionDiagrams() {
    return Column(
      children: [
        _card(292, [
          _at(125, 28, _chip(widget.locale == 'en'?'Dividend':'တည်ကိန်း')),
          _at(
              150,
              95,
              Container(
                alignment: Alignment.center,
                width: 70,
                child: Column(
                  children: [_num('10'), _line(40), _num('2')],
                ),
              )),
          _at(222, 112, _num('=')),
          _at(257, 112, _num('5')),
          _at(290, 118, _chip(widget.locale == 'en'?'Quotient':'စားလဒ်')),
          _at(140, 215, _chip(widget.locale == 'en'?'Divisor':'စားကိန်း')),
        ]),
        SizedBox(height: 24),
        _card(280, [
          _at(233, 26, _chip(widget.locale == 'en'?'Quotient':'စားလဒ်')),
          _at(280, 70, _num('5')),
          _at(85, 115, _chip(widget.locale == 'en'?'Divisor':'စားကိန်း')),
          _at(205, 125, _num('2')),
          _at(240, 118, _line(70)),
          _at(240, 118, Container(width: 2, height: 74, color: Colors.black87)),
          _at(262, 125, _num('10')),
          _at(247, 157, _num('-10')),
          _at(258, 198, _line(42)),
          _at(280, 207, _num('0')),
          _at(325, 118, _chip(widget.locale == 'en'?'Dividend':'တည်ကိန်း')),
          _at(325, 200, _chip(widget.locale == 'en'?'Remainder':'အကြွင်း')),
        ]),
        SizedBox(height: 24),
      ],
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
              _divisionDiagrams(),
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
                              style: FontFamily()
                                  .medium
                                  .copyWith(fontSize: FontSize().twenty),
                            ),
                            textWidget(divisor.toString()),
                            Text(
                              '=',
                              style: FontFamily()
                                  .medium
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
