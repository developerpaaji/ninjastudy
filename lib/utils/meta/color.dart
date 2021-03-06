import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/providers/theme.dart';

class MetaColor {
  final BuildContext context;

  MetaColor(this.context);

  static MetaColor of(BuildContext context) {
    return Provider.of<MetaColor>(context);
  }

  Color get materialAccent => ThemeProvider.of(context).isLight
      ? const Color(0xffeeeeee)
      : Colors.black.withOpacity(0.7);
  Color get mineMessagBackground => Colors.blue.shade50;
  Color get fabDisabled => Colors.teal;
  Color get black =>
      ThemeProvider.of(context).isLight ? Colors.black : Colors.white;
  Color get white =>
      ThemeProvider.of(context).isLight ? Colors.white : Colors.black;
}
