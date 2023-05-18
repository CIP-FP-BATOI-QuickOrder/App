import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import '../../provider/user_provider.dart';
import '../../routes/routes.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatelessWidget {
  final Duration duration = const Duration(seconds: 3);
  final BuildContext context;

  SplashScreen({Key? key, required this.context}) : super(key: key) {
    handleOnInitialize();
  }

  void handleOnInitialize() async {
    Future.delayed(duration).then((_) {
      SharedPreferences.getInstance().then((preferences) async {
        final email = preferences.getString('email');
        final password = preferences.getString('password');
        if (email != null && password != null) {
          final response = await http.get(
              Uri.parse("${Routes.api}user/email=$email/password=$password"));
          if (response.statusCode == 200) {
            User user = User.fromJson(jsonDecode(response.body));
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.setUser(user);
            Navigator.pushNamed(
              context,
              Routes.home,
            );
          }
        } else {
          Navigator.pushNamed(
            context,
            Routes.welcomeScreen,
          );
        }
      });
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
