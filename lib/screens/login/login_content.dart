import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/login/widgets/login_form_widget.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../welcome/widgets/signing_button.dart';
import '../welcome/widgets/social_media_buttons.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> tryLogin() async {
    if (_formState.currentState?.validate() == true) {
      final response = await http
          .get(Uri.parse("${Routes.api}user/email=${_email.text}/password=${_password.text}"));
      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));

        Future.delayed(const Duration(seconds: 1)).then(
          (_) => Navigator.pushNamed(
            context,
            Routes.home,
          ),
        );
      } else {
        context.showCustomFlashMessage(
          status: "failed",
          title: "Error",
          message: "Username and password do not match",
          positionBottom: false,
        );
      }
    }
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
                'Sign In',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 38.0),
              Form(
                key: _formState,
                child: LoginFormWidget(
                  emailController: _email,
                  passwordController: _password,
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.forgotPasswordScreen,
                  ),
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42.0),
                child: ButtonWidget(
                  onPress: () => tryLogin(),
                  title: 'LOGIN',
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
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.registerScreen,
                    ),
                    child: const Text(
                      'Sign Up',
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
