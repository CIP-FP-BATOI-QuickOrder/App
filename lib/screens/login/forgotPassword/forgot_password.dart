import 'package:flutter/material.dart';
import 'package:quick_order/screens/login/forgotPassword/forgot_password_content.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: const SingleChildScrollView(
            child: ForgotPasswordContent(),
          ),
        ),
      ),
    );
  }
}
