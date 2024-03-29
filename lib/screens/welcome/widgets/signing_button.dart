import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final Color buttonColor, titleColor, borderColor;
  final double paddingVertical, paddingHorizontal;

  const ButtonWidget({
    super.key,
    required this.onPress,
    required this.title,
    required this.buttonColor,
    required this.titleColor,
    required this.borderColor,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
        backgroundColor: buttonColor,
        alignment: Alignment.center,
        shadowColor: Colors.black26,
        elevation: 5,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
      ),
    );
  }
}