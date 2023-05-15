import 'package:flutter/widgets.dart';
import 'package:quick_order/screens/welcome/welcome_screen.dart';

import '../screens/login/login.dart';

Map<String, WidgetBuilder> routesApp = {
  "welcome": (_) => WelcomeScreen(),
  "login": (_) => LoginScreen()
};

