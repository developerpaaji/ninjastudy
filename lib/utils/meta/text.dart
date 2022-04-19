import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaText {
  final BuildContext context;

  MetaText(this.context);

  static MetaText of(BuildContext context) {
    return Provider.of<MetaText>(context, listen: false);
  }
}
