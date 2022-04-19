import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaAsset {
  final BuildContext context;

  MetaAsset(this.context);

  static MetaAsset of(BuildContext context) {
    return Provider.of<MetaAsset>(context, listen: false);
  }

  static getAssetPath(String asset) => "assets/images/$asset";

  String get logo => getAssetPath("logo.svg");
  String get avatarBackground => getAssetPath("avatar_background.svg");
}
