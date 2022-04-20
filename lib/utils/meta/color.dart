import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/providers/theme.dart';

class MetaColor {
  final BuildContext context;

  MetaColor(this.context);

  static MetaColor of(BuildContext context) {
    return Provider.of<MetaColor>(context);
  }

  Color get materialAccent => const Color(0xffeeeeee);
  Color get fabDisabled => Colors.teal;
  Color get black =>
      ThemeProvider.of(context).isLight ? Colors.black : Colors.white;
  Color get white =>
      ThemeProvider.of(context).isLight ? Colors.white : Colors.black;
}
