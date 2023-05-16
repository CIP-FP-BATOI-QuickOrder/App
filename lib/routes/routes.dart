import 'package:flutter/widgets.dart';

import 'package:quick_order/screens/splashscreen/splash_screen.dart';

import '../screens/login/forgotPassword/forgot_password.dart';
import '../screens/login/login.dart';
import '../screens/register/register.dart';
import '../screens/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> routesApp = {
  Routes.splashScreen: (BuildContext context) => SplashScreen(context: context),
  Routes.welcomeScreen: (_) => WelcomeScreen(),
  Routes.loginScreen: (_) => LoginScreen(),
  Routes.registerScreen: (_) => RegisterScreen(),
  Routes.forgotPasswordScreen: (_) => ForgotPasswordScreen(),
};

class Routes {
  static const api = "http://localhost:8086/";
  static const splashScreen = "splash_screen";
  static const loginScreen = "login_screen";
  static const welcomeScreen = "welcome_screen";
  static const registerScreen = "register_screen";
  static const forgotPasswordScreen = "forgot_password_screen";
}
