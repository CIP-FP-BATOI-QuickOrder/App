import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/Workers/login/forgotPassword/widgets/forgot_password_form_widget.dart';
import 'package:quick_order/screens/login/forgotPassword/widgets/forgot_password_form_widget.dart';
import 'package:quick_order/screens/login/widgets/login_form_widget.dart';
import 'package:http/http.dart' as http;

import '../../../welcome/widgets/signing_button.dart';
import '../../../welcome/widgets/social_media_buttons.dart';

class WorkersForgotPasswordContent extends StatefulWidget {
  WorkersForgotPasswordContent({super.key, required this.provider});

  WorkerRestaurantProvider provider;

  @override
  State<WorkersForgotPasswordContent> createState() =>
      _WorkersForgotPasswordContentState();
}

class _WorkersForgotPasswordContentState
    extends State<WorkersForgotPasswordContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _nif;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _nif = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _nif.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset('assets/images/header.png'),
            Padding(
              padding: const EdgeInsets.only(
                top: 37,
                left: 27,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                enableFeedback: false,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 92.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Reset restaurant password',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 38.0),
              Form(
                key: _formState,
                child: WorkersForgotPasswordFormWidget(
                  emailController: _nif,
                  passwordController: _password,
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42.0),
                child: ButtonWidget(
                  onPress: () {
                    widget.provider.resetPassword(_nif.text, _password.text);
                    context.showCustomFlashMessage(
                        status: "success",
                        positionBottom: false,
                        message: "Password reset successful",
                        title: "Reset password");
                    Navigator.pop(context);
                  },
                  title: 'RESET',
                  buttonColor: Colors.orange,
                  titleColor: Colors.white,
                  borderColor: Colors.orange,
                  paddingHorizontal: 22.0,
                  paddingVertical: 22.0,
                ),
              ),
              const SizedBox(height: 36.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, Routes.workersLogin,
                        arguments: widget.provider),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.orange,
                        decorationThickness: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Text(
                        'sign in with',
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              const ButtonSigninWith(
                positionButtom: false,
              ),
              const SizedBox(height: 18.0),
            ],
          ),
        )
      ],
    );
  }
}
