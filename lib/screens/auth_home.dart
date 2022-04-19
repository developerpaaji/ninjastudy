import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/screens/home.dart';
import 'package:study/screens/sign_in.dart';
import 'package:study/screens/splash.dart';

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          _loggedIn();
        } else if (state is AuthLoggedOutState) {
          _loggedOut();
        }
      },
      builder: (context, state) {
        if (state is AuthIdleState) {
          return const SplashScreen();
        }
        if (state is AuthSuccessState) {
          return const HomeScreen();
        }
        return const SignInScreen();
      },
    );
  }

  void _loggedIn() {
    // TODO
  }

  void _loggedOut() {
    // TODO
  }
}
