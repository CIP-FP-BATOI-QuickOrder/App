import 'dart:async';

import 'package:flutter/material.dart';
import '../../routes/routes.dart';

class SplashScreen extends StatelessWidget {
  final Duration duration = const Duration(seconds: 3);
  final BuildContext context;

  SplashScreen({Key? key, required this.context}) : super(key: key) {
    handleOnInitialize();
  }

  void handleOnInitialize() async {
    Future.delayed(duration).then((_) {
      Navigator.pushNamed(
        context,
        Routes.welcomeScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/splash.png',
            height: 180,
          ),
        ),
      ),
    );
  }
}
