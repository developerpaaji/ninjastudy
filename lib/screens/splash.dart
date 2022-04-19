import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/utils/meta/asset.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin<SplashScreen> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _runAnimations();
  }

  Future<void> _runAnimations() async {
    await _controller.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    await BlocProvider.of<AuthBloc>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _controller,
        child: Center(
          child: Image.asset(
            MetaAsset.of(context).banner,
            width: MediaQuery.of(context).size.width * 0.75,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
