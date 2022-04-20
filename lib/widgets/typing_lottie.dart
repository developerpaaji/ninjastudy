// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:lottie/lottie.dart';
import 'package:study/utils/meta/asset.dart';
import 'package:study/utils/meta/color.dart';

class TypingLottie extends StatelessWidget {
  const TypingLottie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(colors: [
              MetaColor.of(context).materialAccent,
              MetaColor.of(context).materialAccent.withOpacity(0.8),
            ])),
        child: SizedBox(
          height: 40,
          child: Lottie.asset(
            MetaAsset.of(context).lottieTyping,
          ),
        ),
      ),
    );
  }
}
