import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../utils/ad_helper.dart';

class BannerAdWidget extends StatefulWidget {
  final String? adUnitId; // placement အလိုက် ID ခွဲချင်ရင်
  const BannerAdWidget({super.key, this.adUnitId});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _ad;
  bool _loaded = false;
  AdSize? _size;
  Timer? _retry;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _load(); // MediaQuery လိုလို့ initState မှာ မလုပ်ပါ
  }

  Future<void> _load() async {
    final width = MediaQuery.sizeOf(context).width.truncate();
    // final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);
    // final size = await AdSize.getLandscapeInlineAdaptiveBannerAdSize(width);
    if (!mounted) return;
    if (size == null) {
      _retry = Timer(const Duration(seconds: 45), _load);
      return;
    }
    setState(() => _size = size); // ← အမြင့်ကို ကြိုယူထား (layout မခုန်အောင်)

    _ad = BannerAd(
      adUnitId: widget.adUnitId ?? AdHelper.bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => mounted ? setState(() => _loaded = true) : null,
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          _ad = null;
          if (mounted) setState(() => _loaded = false);
          _retry = Timer(const Duration(seconds: 45), () {
            if (mounted) _load();
          });
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _retry?.cancel();
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = _size;
    if (size == null) return const SizedBox.shrink();
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.only(top: 8), // ခလုတ်တွေနဲ့ ခွာထား
        width: size.width.toDouble(),
        height: size.height.toDouble(),       // load မပြီးခင်လည်း နေရာယူထား
        alignment: Alignment.center,
        child: _loaded && _ad != null ? AdWidget(ad: _ad!) : null,
      ),
    );
  }
}