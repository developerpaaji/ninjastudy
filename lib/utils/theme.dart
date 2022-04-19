import 'package:flutter/material.dart';

const double _fontSizeSubtitle = 14;
const double _fontSizeTitle = 16;
const double _appBarTitleSize = 22;
const double _appBarIconSize = 24;
const double _appBarElevation = 2;
const double _fontSizeHeadline6 = 18;
const double _fontSizeHeadline2 = 36;
const double _labelFontSize = 18;

const buttonPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 54);
ThemeData _createTheme(
    {Color? primary,
    Color? onPrimary,
    bool isLight = true,
    Color? titleColor,
    Color? subtitleColor,
    Color? backgroundColor,
    Color? scaffoldBackground,
    Color? tabBarIndicatorColor,
    Color? labelColor,
    Color? hintColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? shadowColor,
    required Color buttonForeground,
    required Color buttonBackground,
    Color? appBarBackground,
    Color? appBarTitleColor,
    Color? appBarIconColor}) {
  final normalTheme = isLight ? ThemeData.light() : ThemeData.dark();
  final colorScheme =
      isLight ? const ColorScheme.light() : const ColorScheme.dark();
  const buttonPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 54);
  final _inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: isLight ? Colors.black26 : Colors.white24,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(4));

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
      headline2: TextStyle(
        color: titleColor,
        fontSize: _fontSizeHeadline2,
        fontWeight: FontWeight.w700,
      ),
    ),
    shadowColor: shadowColor,
    backgroundColor: backgroundColor,
    indicatorColor: tabBarIndicatorColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary, foregroundColor: onPrimary),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        labelStyle: TextStyle(
            color: labelColor,
            fontSize: _labelFontSize,
            fontWeight: FontWeight.w600),
        hintStyle: TextStyle(
          color: hintColor,
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: _inputBorder.copyWith(
            borderSide:
                _inputBorder.borderSide.copyWith(color: focusedBorderColor)),
        enabledBorder: _inputBorder,
        border: _inputBorder,
        disabledBorder: _inputBorder,
        errorBorder: _inputBorder.copyWith(
            borderSide:
                _inputBorder.borderSide.copyWith(color: errorBorderColor))),
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
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.disabled)
                    ? null
                    : buttonForeground),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.disabled)
                    ? null
                    : buttonBackground),
            padding: MaterialStateProperty.all(buttonPadding))),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonBackground,
      colorScheme: isLight
          ? ColorScheme.light(
              primary: buttonBackground, background: buttonBackground)
          : ColorScheme.dark(
              primary: buttonBackground, background: buttonBackground),
      disabledColor: buttonBackground.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: buttonPadding,
    ),
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
    scaffoldBackground: Colors.white,
    titleColor: titleColor,
    tabBarIndicatorColor: primaryColor,
    shadowColor: Colors.black.withOpacity(0.1),
    subtitleColor: const Color(0xff6B6B6B),
    labelColor: Colors.black,
    focusedBorderColor: const Color(0xffBEBEBE),
    errorBorderColor: Colors.red,
    buttonBackground: const Color(0xff0D0B22),
    buttonForeground: Colors.white,
  );
}

ThemeData get appDarkTheme {
  return _createTheme(
    isLight: false,
    buttonBackground: ThemeData.dark().buttonTheme.colorScheme?.background ??
        ThemeData.dark().primaryColor,
    buttonForeground: Colors.white,
  );
}
