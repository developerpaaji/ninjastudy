import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _isLight;
  final ThemeData lightThemeData;
  final ThemeData darkThemeData;
  ThemeProvider(
      {bool isInitiallyLight = true,
      required this.lightThemeData,
      required this.darkThemeData}) {
    _isLight = isInitiallyLight;
  }

  void switchTheme() {
    _isLight = !_isLight;
    notifyListeners();
  }

  bool get isLight => _isLight;

  ThemeData get themeData => isLight ? lightThemeData : darkThemeData;

  static ThemeProvider of(BuildContext context) =>
      Provider.of<ThemeProvider>(context, listen: false);
}
