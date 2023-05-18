import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../provider/user_provider.dart';
import '../../routes/routes.dart';
import '../welcome/widgets/signing_button.dart';
import 'widgets/card_profile_widget.dart';
import 'widgets/card_setting_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.context});

  final BuildContext? context;

  User? getUser() {
    final userProvider = Provider.of<UserProvider>(context!);
    return userProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size.width / 7),
                  child: Image.asset(
                    'assets/images/profile_header.png',
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      enableFeedback: false,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
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
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 7.2,
                  left: size.width / 2.8,
                  child: Container(
                    width: 110,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/profile_user.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 4.4,
                  left: size.width / 1.9,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: const Icon(
                      Icons.photo_camera,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                getUser()!.name,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  CardProfileWidget(),
                  const SizedBox(height: 30),
                  CardSettingWidget(),
                  const SizedBox(height: 30),
                  ButtonWidget(
                    onPress: () async {
                      final preferences = await SharedPreferences.getInstance();
                      preferences.remove('email');
                      preferences.remove('password');
                      Navigator.pushNamed(context, Routes.welcomeScreen);
                    },
                    title: 'Logout',
                    buttonColor: Colors.orange,
                    titleColor: Colors.white,
                    borderColor: Colors.orange,
                    paddingHorizontal: 0.0,
                    paddingVertical: 18.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
