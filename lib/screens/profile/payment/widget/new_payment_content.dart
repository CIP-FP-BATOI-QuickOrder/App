import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/address.dart';
import 'package:quick_order/models/payment_method.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/widget/edit_address_form_widget.dart';
import 'package:http/http.dart' as http;
import 'package:quick_order/screens/profile/addresses/widget/new_address_form_widget.dart';
import 'package:quick_order/screens/profile/payment/widget/new_payment_form_widget.dart';

import '../../../../models/user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../routes/routes.dart';
import '../../../welcome/widgets/signing_button.dart';

class NewPaymentContent extends StatefulWidget {
  NewPaymentContent({super.key, required this.userProvider});

  UserProvider userProvider;

  @override
  State<NewPaymentContent> createState() => _NewPaymentContentState();
}

class _NewPaymentContentState extends State<NewPaymentContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _creditCart;
  late TextEditingController _bank;
  late TextEditingController _expirationDate;

  late Address address;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _creditCart = TextEditingController();
    _bank = TextEditingController();
    _expirationDate = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _creditCart.dispose();
    _bank.dispose();
    _expirationDate.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (_formState.currentState?.validate() == true) {
      PaymentMethod payment = PaymentMethod(
          id: 0,
          bank: _bank.text,
          creditCart: _creditCart.text,
          expirationDate: _expirationDate.text,
          name: _name.text);

      Map<String, dynamic> userJson = payment.toJson();

      final response = await http.post(
        Uri.parse("${Routes.api}pay/${widget.userProvider.user!.id}"),
        body: jsonEncode(userJson),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        widget.userProvider.user!.paymentMethods.add(payment);
        widget.userProvider.notifyListeners();

        context.showCustomFlashMessage(
          status: "success",
          title: "Created",
          message: "Your address has been created",
          positionBottom: false,
        );
        widget.userProvider.notifyListeners();
        Navigator.pop(context);
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
                'Edit address',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 38.0),
              Form(
                key: _formState,
                child: NewPaymentFormWidget(
                  expirationDate: _expirationDate,
                  creditCart: _creditCart,
                  bank: _bank,
                  name: _name,
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
