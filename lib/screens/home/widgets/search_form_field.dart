import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool showObscureToggle;
  final int maxLength;
  final int? maxLines;

  final VoidCallback? onPressSufixobscureTextIcon;
  final String? Function(String?)? onSubmitted;

  const FormFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.showObscureToggle = false,
    this.maxLength = 30,
    this.maxLines,
    this.onSubmitted,
    this.onPressSufixobscureTextIcon,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmitted,
        maxLines: obscureText ? 1 : maxLines,
        maxLength: maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 20,
          ),
          prefix: const Padding(
            padding: EdgeInsets.only(left: 16),
          ),
          suffixIcon: showObscureToggle
              ? InkWell(
                  onTap: onPressSufixobscureTextIcon,
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                )
              : null,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          counter: null,
          counterText: "",
          filled: true,
          isDense: true,
          errorMaxLines: 1,
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
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
