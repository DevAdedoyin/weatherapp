// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:flutter/widgets.dart';
//
// class AdsLoaderWidget extends StatefulWidget {
//   const AdsLoaderWidget({super.key});
//
//   @override
//   State<AdsLoaderWidget> createState() => _AdsLoaderWidgetState();
// }
//
// class _AdsLoaderWidgetState extends State<AdsLoaderWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
//
//   /// Loads a banner ad.
//   void _loadAd() {
//     final bannerAd = BannerAd(
//       size: widget.adSize,
//       adUnitId: widget.adUnitId,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           if (!mounted) {
//             ad.dispose();
//             return;
//           }
//           setState(() {
//             _bannerAd = ad as BannerAd;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, error) {
//           debugPrint('BannerAd failed to load: $error');
//           ad.dispose();
//         },
//       ),
//     );
//
//     // Start loading.
//     bannerAd.load();
//   }
// }
