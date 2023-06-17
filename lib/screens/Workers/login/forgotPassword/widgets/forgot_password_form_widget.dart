import 'package:flutter/material.dart';

class WorkersForgotPasswordFormWidget extends StatefulWidget {
  final TextEditingController emailController, passwordController;

  const WorkersForgotPasswordFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<WorkersForgotPasswordFormWidget> createState() => _WorkersForgotPasswordFormWidgetState();
}

class _WorkersForgotPasswordFormWidgetState extends State<WorkersForgotPasswordFormWidget> {
  bool passwordVisible = true;
  RegExp mailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).+$');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'NIF',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sorry, nif can\'t be empty.';
            }
            return null;
          },
          controller: widget.emailController,
          decoration: InputDecoration(
            hintText: "NIF",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            prefix: const Padding(
              padding: EdgeInsets.only(left: 16),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Password',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sorry, password can not be empty';
            } else if (value.length < 8) {
              return 'Sorry, password length must be 8 characters or greater';
            } else if (!passwordRegex.hasMatch(value)) {
              return 'Need to use: 1 number and 1 capital letter';
            }
            return null;
          },
          controller: widget.passwordController,
          decoration: InputDecoration(
            hintText: "New Password",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            prefix: const Padding(
              padding: EdgeInsets.only(left: 16),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
