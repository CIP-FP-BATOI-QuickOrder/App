import 'package:flutter/widgets.dart';
import 'package:quick_order/screens/register/register.dart';
import 'package:quick_order/screens/welcome/welcome_screen.dart';

import '../screens/login/login.dart';

Map<String, WidgetBuilder> routesApp = {
  Routes.welcomeScreen: (_) => WelcomeScreen(),
  Routes.loginScreen: (_) => LoginScreen(),
  Routes.registerScreen: (_) => RegisterScreen(),
};

class Routes {
  static const api = "http://localhost:8086/";
  static const loginScreen = "login_screen";
  static const welcomeScreen = "welcome_screen";
  static const registerScreen = "register_screen";
}
