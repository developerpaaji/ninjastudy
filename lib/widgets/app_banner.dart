import 'package:flutter/material.dart';
import 'package:study/utils/meta/asset.dart';

class AppBanner extends StatelessWidget {
  final double? width;
  final double? height;
  const AppBanner({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      MetaAsset.of(context).banner,
      height: height,
      width: width,
    );
  }
}
