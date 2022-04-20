import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaAsset {
  final BuildContext context;

  MetaAsset(this.context);

  static MetaAsset of(BuildContext context) {
    return Provider.of<MetaAsset>(context, listen: false);
  }

  _getImagePath(String asset) => "assets/images/$asset";
  _getLottiePath(String asset) => "assets/lottie/$asset";

  String get banner => _getImagePath("banner.png");
  String get logo => _getImagePath("logo.jpeg");
  String get lottieAI => _getLottiePath("ai.json");
  String get lottieTyping => _getLottiePath("typing-status.json");
}
