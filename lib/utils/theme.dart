import 'package:flutter/material.dart';

const double _fontSizeSubtitle = 14;
const double _fontSizeTitle = 16;
const double _appBarTitleSize = 22;
const double _appBarIconSize = 24;
const double _appBarElevation = 2;
const double _fontSizeHeadline6 = 18;
const double _fontSizeHeadline3 = 32;

ThemeData _createTheme(
    {Color? primary,
    Color? onPrimary,
    bool isLight = true,
    Color? titleColor,
    Color? subtitleColor,
    Color? backgroundColor,
    Color? scaffoldBackground,
    Color? tabBarIndicatorColor,
    Color? shadowColor,
    Color? appBarBackground,
    Color? appBarTitleColor,
    Color? appBarIconColor}) {
  final normalTheme = isLight ? ThemeData.light() : ThemeData.dark();
  final colorScheme =
      isLight ? const ColorScheme.light() : const ColorScheme.dark();
  return normalTheme.copyWith(
    primaryColor: primary,
    colorScheme: colorScheme.copyWith(primary: primary, onPrimary: onPrimary),
    textTheme: TextTheme(
      subtitle1: TextStyle(
        color: titleColor,
        fontSize: _fontSizeTitle,
      ),
      subtitle2: TextStyle(
        color: subtitleColor,
        fontSize: _fontSizeSubtitle,
      ),
      headline6: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.w500,
        fontSize: _fontSizeHeadline6,
      ),
      headline3: TextStyle(
        color: titleColor,
        fontSize: _fontSizeHeadline3,
        fontWeight: FontWeight.w700,
      ),
    ),
    shadowColor: shadowColor,
    backgroundColor: backgroundColor,
    indicatorColor: tabBarIndicatorColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary, foregroundColor: onPrimary),
    tabBarTheme: TabBarTheme(
        labelColor: titleColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(vertical: 4),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
                width: 4,
                color: tabBarIndicatorColor ?? normalTheme.indicatorColor)),
        unselectedLabelColor: subtitleColor,
        unselectedLabelStyle: const TextStyle(fontSize: _fontSizeTitle),
        labelStyle: const TextStyle(
            fontSize: _fontSizeTitle, fontWeight: FontWeight.w600)),
    appBarTheme: AppBarTheme(
        backgroundColor: appBarBackground,
        centerTitle: true,
        elevation: _appBarElevation,
        iconTheme: IconThemeData(color: appBarIconColor, size: _appBarIconSize),
        titleTextStyle: TextStyle(
            color: appBarTitleColor,
            fontSize: _appBarTitleSize,
            fontWeight: FontWeight.w700)),
    scaffoldBackgroundColor: scaffoldBackground,
  );
}

ThemeData get appLightTheme {
  Color titleColor = const Color(0xff161A33);
  Color primaryColor = const Color(0xff3558CD);
  return _createTheme(
      primary: primaryColor,
      onPrimary: Colors.white,
      appBarTitleColor: titleColor,
      appBarIconColor: titleColor,
      appBarBackground: Colors.white,
      isLight: true,
      backgroundColor: Colors.white,
      titleColor: titleColor,
      tabBarIndicatorColor: primaryColor,
      shadowColor: Colors.black.withOpacity(0.1),
      subtitleColor: const Color(0xff6B6B6B));
}

ThemeData get appDarkTheme {
  return _createTheme(isLight: false);
}
