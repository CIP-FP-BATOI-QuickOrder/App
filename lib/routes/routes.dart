import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/products_provider.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'package:quick_order/screens/Workers/edit_product/edit_product.dart';
import 'package:quick_order/screens/Workers/home/home_screen.dart';
import 'package:quick_order/screens/Workers/login/forgotPassword/forgot_password.dart';
import 'package:quick_order/screens/Workers/login/forgotPassword/forgot_password_content.dart';
import 'package:quick_order/screens/Workers/login/login.dart';
import 'package:quick_order/screens/Workers/new_product/new_product.dart';
import 'package:quick_order/screens/Workers/register/workers_register.dart';
import 'package:quick_order/screens/Workers/welcome_screen/workers_welcome_screen.dart';
import 'package:quick_order/screens/checkout/checkout_screen.dart';
import 'package:quick_order/screens/checkout/shipping_dates/shipping_dates_screen.dart';
import 'package:quick_order/screens/home/home_screen.dart';
import 'package:quick_order/screens/home/search_screen.dart';
import 'package:quick_order/screens/profile/addresses/address_screen.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/edit_address.dart';
import 'package:quick_order/screens/profile/addresses/widget/new_address.dart';
import 'package:quick_order/screens/profile/edit_profile/edit_profile.dart';
import 'package:quick_order/screens/profile/history/search_screen.dart';
import 'package:quick_order/screens/profile/payment/edit_payment/edit_payment.dart';
import 'package:quick_order/screens/profile/payment/payment_screen.dart';
import 'package:quick_order/screens/profile/payment/widget/new_payment.dart';
import 'package:quick_order/screens/profile/profile_screen.dart';
import 'package:quick_order/screens/restaurant_detail/restaurant_detail_screen.dart';
import 'package:quick_order/screens/restaurant_detail/reviews/restaurant_reviews_screen.dart';

import 'package:quick_order/screens/splashscreen/splash_screen.dart';

import '../models/restaurant.dart';
import '../provider/user_provider.dart';
import '../screens/home/favorite_screen.dart';
import '../screens/login/forgotPassword/forgot_password.dart';
import '../screens/login/login.dart';
import '../screens/register/register.dart';
import '../screens/welcome/welcome_screen.dart';

Map<String, WidgetBuilder> routesApp = {
  Routes.splashScreen: (BuildContext context) => SplashScreen(context: context),
  Routes.welcomeScreen: (_) => const WelcomeScreen(),
  Routes.loginScreen: (_) => const LoginScreen(),
  Routes.registerScreen: (_) => const RegisterScreen(),
  Routes.forgotPasswordScreen: (_) => const ForgotPasswordScreen(),
  Routes.home: (_) => const HomeScreen(),
  Routes.profileScreen: (_) => ProfileScreen(context:  ModalRoute.of(_)!.subtreeContext),
  Routes.restaurantSearchScreen: (_) => SearchScreen(query:  ModalRoute.of(_)!.settings.arguments as String),
  Routes.restaurantFavoriteScreen: (_) => const FavoritesScreen(),
  Routes.restaurantDetailScreen: (_) => RestaurantDetailScreen(restaurant: ModalRoute.of(_)!.settings.arguments as Restaurant, user: Provider.of<UserProvider>(_).user!),
  Routes.editProfile: (_) => EditProfileScreen(userProvider: Provider.of<UserProvider>(_)),
  Routes.addresses: (_) => AddressScreen(),
  Routes.editAddress: (_) => EditAddressScreen(userProvider: Provider.of<UserProvider>(_), id: ModalRoute.of(_)!.settings.arguments as int),
  Routes.newAddress: (_) => NewAddressScreen(userProvider: Provider.of<UserProvider>(_)),
  Routes.payment: (_) => PaymentScreen(),
  Routes.newPayment: (_) => NewPaymentScreen(userProvider: Provider.of<UserProvider>(_)),
  Routes.editPayment: (_) => EditPaymentScreen(userProvider: Provider.of<UserProvider>(_), id: ModalRoute.of(_)!.settings.arguments as int),
  Routes.history: (_) => HistoryScreen(),
  Routes.reviews: (_) => ReviewsScreen(restaurant: ModalRoute.of(_)!.settings.arguments as Restaurant, user: Provider.of<UserProvider>(_).user!),
  Routes.checkout: (_) => CheckoutScreen(provider: ModalRoute.of(_)!.settings.arguments as ProductsProvider),
  Routes.shippindDates: (_) => ShippingDatesScreen(provider: ModalRoute.of(_)!.settings.arguments as ProductsProvider),
  Routes.workersWelcome: (_) => WorkersWelcomeScreen(),
  Routes.workersRegister: (_) => WorkersRegisterScreen(provider: ModalRoute.of(_)!.settings.arguments as WorkerRestaurantProvider),
  Routes.workersLogin: (_) => WorkersLoginScreen(provider: ModalRoute.of(_)!.settings.arguments as WorkerRestaurantProvider),
  Routes.workersForgotPasswordScreen: (_) => WorkersForgotPasswordScreen(provider: ModalRoute.of(_)!.settings.arguments as WorkerRestaurantProvider),
  Routes.workersHome: (_) => WorkersHomeScreen(provider:  ModalRoute.of(_)!.settings.arguments as WorkerRestaurantProvider),
  Routes.editProduct: (_) {
    final arguments = ModalRoute.of(_)!.settings.arguments as Map<String, dynamic>;
    final provider = arguments['provider'] as WorkerRestaurantProvider;
    final id = arguments['id'] as int;
    return EditProductScreen(provider: provider, id: id);
  },
  Routes.newProduct: (_) => NewProductScreen(provider: ModalRoute.of(_)!.settings.arguments as WorkerRestaurantProvider),
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
  static const addToCart = "add_to_cart_widget";
  static const editProfile = "edit_profile";
  static const addresses = "address_screen";
  static const editAddress = "edit_address";
  static const newAddress = "new_address_content";
  static const payment = "payment_screen";
  static const newPayment = "new_payment";
  static const editPayment = "edit_payment";
  static const history = "history";
  static const reviews = "reviews";
  static const checkout = "checkout";
  static const shippindDates = "shipping_dates";
  static const workersWelcome = "workers_welcome";
  static const workersRegister = "workers_register";
  static const workersLogin = "workers_login";
  static const workersForgotPasswordScreen = "workersForgotPasswordScreen";
  static const workersHome = "workers_home";
  static const editProduct = "edit_product";
  static const newProduct = "new_product";
}
