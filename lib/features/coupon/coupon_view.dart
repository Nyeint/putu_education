import 'package:flutter/material.dart';

const _green = Color(0xFF3FA564);
const _greenDark = Color(0xFF1E6B3A);
const _greenLight = Color(0xFFE8F8EE);
const _navy = Color(0xFF16163F);

class Coupon {
  final int percent;
  final int minSpend;
  final String category;
  final String validUntil;

  const Coupon(this.percent, this.minSpend, this.category, this.validUntil);
}

// ponytail: static sample data, replace with API/bloc once the endpoint exists
const _available = [
  Coupon(10, 100000, 'All Products', '31 Oct 2026'),
  Coupon(5, 50000, 'Home Appliances', '25 Oct 2026'),
  Coupon(15, 200000, 'Air-Con Parts', '30 Oct 2026'),
  Coupon(20, 300000, 'Cleaning Supplies', '28 Oct 2026'),
  Coupon(8, 80000, 'Fans', '20 Oct 2026'),
  Coupon(12, 150000, 'Selected Shops', '18 Oct 2026'),
];

class CouponView extends StatelessWidget {
  const CouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: _navy,
          titleSpacing: 0,
          title: const Text('Coupons',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
          bottom: const TabBar(
            labelColor: _green,
            unselectedLabelColor: Colors.black54,
            indicatorColor: _green,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: 'Available (12)'),
              Tab(text: 'Collected (3)'),
              Tab(text: 'Expired (5)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _available.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => CouponCard(coupon: _available[i]),
            ),
            const Center(child: Text('No collected coupons')),
            const Center(child: Text('No expired coupons')),
          ],
        ),
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback? onCollect;

  const CouponCard({super.key, required this.coupon, this.onCollect});

  String _ks(int n) => n.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');

  Widget _meta(IconData icon, String text) => Row(
        children: [
          Icon(icon, size: 15, color: Colors.black45),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 96,
            height: 88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _greenLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    text: '${coupon.percent}',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    children: const [
                      TextSpan(text: '%', style: TextStyle(fontSize: 22)),
                    ],
                  ),
                  style: const TextStyle(color: _greenDark),
                ),
                const Text('OFF',
                    style: TextStyle(
                        color: _greenDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${coupon.percent}% Off',
                    style: const TextStyle(
                        color: _navy, fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text('Min. Spend ${_ks(coupon.minSpend)} Ks',
                    style: const TextStyle(
                        color: _navy, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                _meta(Icons.shopping_cart_outlined, coupon.category),
                const SizedBox(height: 4),
                _meta(Icons.calendar_today_outlined,
                    'Valid until ${coupon.validUntil}'),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onCollect ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Collect',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
