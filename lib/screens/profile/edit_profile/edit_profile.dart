import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/edit_profile/edit_profile_content.dart';

import '../../../models/user.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key, required this.userProvider});
  UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: EditProfileContent(userProvider: userProvider,),
          ),
        ),
      ),
    );
  }
}
