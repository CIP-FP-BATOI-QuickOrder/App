import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Order',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: Routes.splashScreen,
        routes: routesApp,
      ),
    );
  }
}
