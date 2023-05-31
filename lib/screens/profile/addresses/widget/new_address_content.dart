import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/address.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/widget/edit_address_form_widget.dart';
import 'package:http/http.dart' as http;
import 'package:quick_order/screens/profile/addresses/widget/new_address_form_widget.dart';

import '../../../../models/user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../routes/routes.dart';
import '../../../welcome/widgets/signing_button.dart';

class NewAddressContent extends StatefulWidget {
  NewAddressContent({super.key, required this.userProvider});

  UserProvider userProvider;

  @override
  State<NewAddressContent> createState() => _NewAddressContentState();
}

class _NewAddressContentState extends State<NewAddressContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _number;
  late TextEditingController _name;
  late TextEditingController _city;
  late TextEditingController _cp;
  late TextEditingController _address;
  late TextEditingController _addressName;

  late Address address;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _address = TextEditingController();
    _addressName = TextEditingController();
    _city = TextEditingController();
    _cp = TextEditingController();
    _number = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _number.dispose();
    _cp.dispose();
    _city.dispose();
    _addressName.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (_formState.currentState?.validate() == true) {
      Address newAddress = Address(
          name: _name.text,
          id: 0,
          city: _city.text,
          cp: int.parse(_cp.text),
          number: int.parse(_number.text),
          address: _address.text,
          addressName: _addressName.text);

      Map<String, dynamic> addressJson = newAddress.toJson();

      final response = await http.post(
        Uri.parse("${Routes.api}address/${widget.userProvider.user!.id}"),
        body: jsonEncode(addressJson),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        widget.userProvider.user!.addresses.add(newAddress);
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
                child: NewAddressFormWidget(
                  address: _address,
                  number: _number,
                  cp: _cp,
                  addressName: _addressName,
                  city: _city,
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
