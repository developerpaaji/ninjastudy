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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthIdleState) {
          return const SplashScreen();
        }
        if (state is AuthSuccessState) {
          return HomeScreen(user: state.user);
        }
        return const SignInScreen();
      },
    );
  }
}
