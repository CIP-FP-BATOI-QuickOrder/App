import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/user.dart';
import 'package:quick_order/screens/register/widgets/register_form_widget.dart';
import 'package:http/http.dart' as http;

import '../../routes/routes.dart';
import '../welcome/widgets/signing_button.dart';
import '../welcome/widgets/social_media_buttons.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({super.key});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _surname;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _surname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (_formState.currentState?.validate() == true) {

      final   response = await  http.post(Uri.parse("${Routes.api}user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': _name.text,
          'surname': _surname.text,
          'email': _email.text,
          'password': _password.text,
          'phone': _phone.text,
          'credit': '0',
        }),
      );
      if(response.statusCode == 201  ){
        Future.delayed(const Duration(seconds: 2)).then(
              (_) => Navigator.pushNamed(
            context,
            Routes.loginScreen,
          ),
        );
      }else{
        context.showCustomFlashMessage(
          status: "failed",
          title: "Error",
          message: "Something went wrong",
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
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 38.0),
              Form(
                key: _formState,
                child: RegisterFormWidget(
                  nameController: _name,
                  surnameController: _surname,
                  emailController: _email,
                  passwordController: _password,
                  phoneController: _phone,
                ),
              ),
              const SizedBox(height: 28.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42.0),
                child: ButtonWidget(
                  onPress: () => register(),
                  title: 'SIGN UP',
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
                  Text(
                    'Already have an account?',
                    style: context.theme.textTheme.subtitle2!.copyWith(
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.loginScreen,
                    ),
                    child: Text(
                      'Sign In',
                      style: context.theme.textTheme.subtitle2!.copyWith(
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
                        'sign up with',
                        style: TextStyle(color: Colors.black26),
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
        ),
      ],
    );
  }
}
