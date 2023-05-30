import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/address.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/widget/edit_address_form_widget.dart';
import 'package:http/http.dart' as http;

import '../../../../models/user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../routes/routes.dart';
import '../../../welcome/widgets/signing_button.dart';

class EditAddressContent extends StatefulWidget {
  EditAddressContent({super.key, required this.userProvider, required this.id});

  UserProvider userProvider;
  int id;

  @override
  State<EditAddressContent> createState() => _EditAddressContentState();
}

class _EditAddressContentState extends State<EditAddressContent> {
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
    address = widget.userProvider.getAddressById(widget.id);
    _name = TextEditingController();
    _name.text = address.name;
    _address = TextEditingController();
    _address.text = address.address;
    _addressName = TextEditingController();
    _addressName.text = address.addressName;
    _city = TextEditingController();
    _city.text = address.city;
    _cp = TextEditingController();
    _cp.text = address.cp.toString();
    _number = TextEditingController();
    _number.text = address.number.toString();
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
          id: widget.id,
          city: _city.text,
          cp: int.parse(_cp.text),
          number: int.parse(_number.text),
          address: _address.text,
          addressName: _addressName.text);

      Map<String, dynamic> addressJson = newAddress.toJson();

      final response = await http.put(
        Uri.parse("${Routes.api}address/${widget.id}"),
        body: jsonEncode(addressJson),
        headers: {'Content-Type': 'application/json'},
      );

      widget.userProvider.updateAddressById(address);

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
                child: EditAddressFormWidget(
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
