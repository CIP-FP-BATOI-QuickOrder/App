import 'package:flutter/material.dart';
import 'package:quick_order/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Order',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: Routes.splashScreen,
      routes: routesApp,
    );
  }
}

