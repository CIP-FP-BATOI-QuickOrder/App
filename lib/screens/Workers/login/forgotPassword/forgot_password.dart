import 'package:flutter/material.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'forgot_password_content.dart';

class WorkersForgotPasswordScreen extends StatelessWidget {
  WorkersForgotPasswordScreen({super.key, required this.provider});
  WorkerRestaurantProvider provider;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: WorkersForgotPasswordContent(provider: provider,),
          ),
        ),
      ),
    );
  }
}
