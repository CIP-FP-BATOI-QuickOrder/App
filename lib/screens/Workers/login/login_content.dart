import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'package:quick_order/screens/Workers/login/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:quick_order/routes/routes.dart';

import '../../welcome/widgets/signing_button.dart';
import '../../welcome/widgets/social_media_buttons.dart';

class WorkersLoginContent extends StatefulWidget {
  WorkersLoginContent({super.key, required this.provider});
  WorkerRestaurantProvider provider;
  @override
  State<WorkersLoginContent> createState() => _WorkersLoginContentState();
}

class _WorkersLoginContentState extends State<WorkersLoginContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _nif;
  late TextEditingController _password;
  bool rememberPassword = false;

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
                'Restaurant Sign In',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 38.0),
              Form(
                key: _formState,
                child: WorkersLoginFormWidget(
                  nifController: _nif,
                  passwordController: _password,
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.workersForgotPasswordScreen,
                    arguments: widget.provider
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
                  onPress: () async {
                    if (await widget.provider.login(_nif.text, _password.text)){
                      Navigator.pushNamed(context, Routes.home);
                    }else{
                      context.showCustomFlashMessage(
                        status: "failed",
                        title: "Error",
                        message: "Nif or password are not correct",
                        positionBottom: false
                      );
                    }
                  },
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
                      Routes.workersRegister,
                      arguments: widget.provider
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
