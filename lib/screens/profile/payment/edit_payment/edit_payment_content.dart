import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/address.dart';
import 'package:quick_order/models/payment_method.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/widget/edit_address_form_widget.dart';
import 'package:http/http.dart' as http;
import 'package:quick_order/screens/profile/payment/edit_payment/widget/edit_payment_form_widget.dart';

import '../../../../models/user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../routes/routes.dart';
import '../../../welcome/widgets/signing_button.dart';

class EditPaymentContent extends StatefulWidget {
  EditPaymentContent({super.key, required this.userProvider, required this.id});

  UserProvider userProvider;
  int id;

  @override
  State<EditPaymentContent> createState() => _EditPaymentContentState();
}

class _EditPaymentContentState extends State<EditPaymentContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _creditCart;
  late TextEditingController _bank;
  late TextEditingController _expirationDate;

  late PaymentMethod paymentMethod;

  @override
  void initState() {
    super.initState();
    paymentMethod = widget.userProvider.getPaymentById(widget.id);
    _name = TextEditingController();
    _name.text = paymentMethod.name;
    _creditCart = TextEditingController();
    _creditCart.text = paymentMethod.creditCart;
    _bank = TextEditingController();
    _bank.text = paymentMethod.bank;
    _expirationDate = TextEditingController();
    _expirationDate.text = paymentMethod.expirationDate;
  }

  @override
  void dispose() {
    _name.dispose();
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

      Map<String, dynamic> addressJson = payment.toJson();

      final response = await http.put(
        Uri.parse("${Routes.api}pay/${widget.id}"),
        body: jsonEncode(addressJson),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        widget.userProvider.updatePaymentById(payment);
        final response = await http.get(
          Uri.parse("${Routes.api}user/id=${widget.userProvider.user!.id}"),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);

          widget.userProvider.setUser(User.fromJson(jsonData));
        }
        widget.userProvider.notifyListeners();
        context.showCustomFlashMessage(
          status: "success",
          title: "Edited",
          message: "Your address has been editted",
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
                child: EditPaymentFormWidget(
                  name: _name,
                  bank: _bank,
                  creditCart: _creditCart,
                  expirationDate: _expirationDate,
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
