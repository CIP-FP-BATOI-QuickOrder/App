import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAddressFormWidget extends StatefulWidget {
  final TextEditingController number;
  final TextEditingController name;
  final TextEditingController city;
  final TextEditingController cp;
  final TextEditingController address;
  final TextEditingController addressName;

  const EditAddressFormWidget(
      {super.key,
      required this.addressName,
      required this.address,
      required this.city,
      required this.cp,
      required this.number,
      required this.name});

  @override
  State<EditAddressFormWidget> createState() => _EditAddressFormWidgetState();
}

class _EditAddressFormWidgetState extends State<EditAddressFormWidget> {
  bool passwordVisible = true;
  RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).+$');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Address name',
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
              return 'Name can\'t be empty.';
            }
            return null;
          },
          controller: widget.addressName,
          decoration: InputDecoration(
            hintText: "Address name",
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
            'Direction',
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
              return 'Direction can\'t be empty.';
            }
            return null;
          },
          controller: widget.address,
          decoration: InputDecoration(
            hintText: "Direction",
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
            'Number',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Number can\'t be empty.';
            }
            return null;
          },
          controller: widget.number,
          decoration: InputDecoration(
            hintText: "number",
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
            'Name',
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
              return 'Name can\'t be empty';
            }
            return null;
          },
          controller: widget.name,
          decoration: InputDecoration(
            hintText: "Name",
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
            'CP',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'CP can\'t be empty.';
            }
            return null;
          },
          controller: widget.cp,
          decoration: InputDecoration(
            hintText: "CP",
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
      ],
    );
  }
}
