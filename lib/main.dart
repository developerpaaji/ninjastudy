import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/config/app.dart';
import 'package:study/locator.dart';
import 'package:study/providers/theme.dart';
import 'package:study/screens/home.dart';
import 'package:study/services/auth.dart';
import 'package:study/services/error_handler.dart';
import 'package:study/utils/meta/asset.dart';
import 'package:study/utils/meta/color.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/utils/theme.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(const MyApp());
    FlutterError.onError = locator.get<ErrorHandler>().recordError;
  }, (error, stack) {
    locator.get<ErrorHandler>().recordError(error, stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(
            lightThemeData: appLightTheme, darkThemeData: appDarkTheme),
        builder: (context, child) {
          return Theme(
            data: ThemeProvider.of(context).themeData,
            child: MultiProvider(
              providers: [
                // Injecting all metadata on top of app

                Provider<MetaText>(create: (context) => MetaText(context)),
                Provider<MetaAsset>(create: (context) => MetaAsset(context)),
                Provider<MetaColor>(create: (context) => MetaColor(context)),
                // Auth bloc
                BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(locator.get<AuthService>()),
                )
              ],
              child: MaterialApp(
                title: appName,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const HomeScreen(),
              ),
            ),
          );
        });
  }
}
