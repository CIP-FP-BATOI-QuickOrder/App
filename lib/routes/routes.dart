import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/screens/home/home_screen.dart';
import 'package:quick_order/screens/home/search_screen.dart';
import 'package:quick_order/screens/home/widgets/restaurant_search_card_widget.dart';
import 'package:quick_order/screens/profile/profile_screen.dart';

import 'package:quick_order/screens/splashscreen/splash_screen.dart';

import '../provider/user_provider.dart';
import '../screens/home/favorite_screen.dart';
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
  Routes.home: (_) => HomeScreen(),
  Routes.profileScreen: (_) => ProfileScreen(context:  ModalRoute.of(_)!.subtreeContext),
  Routes.restaurantSearchScreen: (_) => SearchScreen(query:  ModalRoute.of(_)!.settings.arguments as String),
  Routes.restaurantFavoriteScreen: (_) => FavoritesScreen()
};

class Routes {
  static const api = "http://192.168.1.24:8086/";
  static const apache = "http://192.168.1.24/";
  static const splashScreen = "splash_screen";
  static const loginScreen = "login_screen";
  static const welcomeScreen = "welcome_screen";
  static const registerScreen = "register_screen";
  static const forgotPasswordScreen = "forgot_password_screen";
  static const profileScreen = "profile_screen";
  static const restaurantFavoriteScreen = "restaurant_favorite_screen";
  static const restaurantSearchScreen = "restaurant_search_screen";
  static const restaurantDetailScreen = "restaurant_detail_screen";
  static const home = "home";
}
