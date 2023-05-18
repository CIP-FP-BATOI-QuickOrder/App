import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/screens/welcome/widgets/signing_media_button.dart';

import '../../../routes/routes.dart';

class ButtonSigninWith extends StatelessWidget {
  final bool positionButtom;

  const ButtonSigninWith({
    Key? key,
    required this.positionButtom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ButtonSigningWidget(
              onPress: () => context.showCustomFlashMessage(
                    status: 'info',
                    positionBottom: positionButtom,
                  ),
              title: 'FACEBOOK',
              icon: 'assets/icons/facebook.png',
              buttonColor: Colors.white,
              titleColor: Colors.black,
              shadowColor: Colors.white),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: ButtonSigningWidget(
              onPress: () => context.showCustomFlashMessage(
                status: 'info',
                positionBottom: positionButtom,
              ),
              title: 'GOOGLE',
              icon: 'assets/icons/google.png',
              buttonColor: Colors.white,
              titleColor: Colors.black,
              shadowColor: Colors.white),
        ),
      ],
    );
  }
}
