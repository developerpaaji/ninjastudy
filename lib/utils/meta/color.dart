import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaColor {
  final BuildContext context;

  MetaColor(this.context);

  static MetaColor of(BuildContext context) {
    return Provider.of<MetaColor>(context);
  }
}
