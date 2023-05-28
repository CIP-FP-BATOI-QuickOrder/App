import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/address.dart';
import 'package:quick_order/models/payment_method.dart';
import 'package:quick_order/screens/register/widgets/register_form_widget.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../routes/routes.dart';
import '../../welcome/widgets/signing_button.dart';

class EditProfileContent extends StatefulWidget {
  EditProfileContent({super.key, required this.userProvider});

  UserProvider userProvider;

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _surname;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    User user = widget.userProvider.user!;
    _name = TextEditingController();
    _surname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();

    _name.text = user.name;
    _surname.text = user.surname;
    _email.text = user.email;
    _password.text = user.password;
    _phone.text = user.phone;
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

  Future<void> save() async {
    if (_formState.currentState?.validate() == true) {
      List<Address> addresses = [];
      List<PaymentMethod> paymentMethods = [];
      User user = User(
        id: 0,
        name: _name.text,
        surname: _surname.text,
        email: _email.text,
        password: _password.text,
        phone: _phone.text,
        credit: 0,
        photo: " ",
        addresses: addresses,
        paymentMethods: paymentMethods,
      );

      Map<String, dynamic> userJson = user.toJson();


        final response = await http.post(
          Uri.parse("${Routes.api}user/${widget.userProvider.user!.id}"),
          body: jsonEncode(userJson),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final response = await http.get(
            Uri.parse("${Routes.api}user/id=${widget.userProvider.user!.id}"),
            headers: {'Content-Type': 'application/json'},
          );
          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);

            widget.userProvider.setUser(User.fromJson(jsonData));
          }

          context.showCustomFlashMessage(
            status: "success",
            title: "Edited",
            message: "Your profile has been editted",
            positionBottom: false,
          );
          Navigator.pushNamed(
            context,
            Routes.profileScreen,
          );
        } else {
          context.showCustomFlashMessage(
            status: "failed",
            title: "Error",
            message: "Something went wrong",
            positionBottom: false,
          );
        }

    } else {
      context.showCustomFlashMessage(
        status: "failed",
        title: "Error",
        message: "Something went wrong",
        positionBottom: false,
      );
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
                'Edit your Profile',
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
                  onPress: () => save(),
                  title: 'SAVE',
                  buttonColor: Colors.orange,
                  titleColor: Colors.white,
                  borderColor: Colors.orange,
                  paddingHorizontal: 22.0,
                  paddingVertical: 22.0,
                ),
              ),
              const SizedBox(height: 36.0),
            ],
          ),
        ),
      ],
    );
  }
}
