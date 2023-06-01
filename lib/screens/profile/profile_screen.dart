import 'dart:io';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';

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
    final ImagePicker picker = ImagePicker();
    User? user = getUser();

    Future<void> enviarFoto(String url, File file) async {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      final fileMultipart = await http.MultipartFile.fromPath(
          'photo', file.path,
          contentType: MediaType('image', 'jpeg'));

      request.files.add(fileMultipart);

      await request.send();
    }

    Future<void> _pickImage() async {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        File photofile = File(photo.path);
        enviarFoto("${Routes.api}user/upload=${user?.id}", photofile);
      }
    }

    Future<void> _checkPermissionAndPickImage() async {
      if (await Permission.camera.request().isGranted) {
        _pickImage();
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView(
            children: [
              Column(
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
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Text('Error loading image');
                                } else {
                                  return Image.network(
                                      '${Routes.apache}${user?.photo}',
                                      fit: BoxFit.fill);
                                }
                              },
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
                          child: IconButton(
                            onPressed: () {
                              _checkPermissionAndPickImage();
                            },
                            icon: const Icon(
                              Icons.photo_camera,
                              size: 14,
                              color: Colors.grey,
                            ),
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
                  Center(
                    child: InkWell(
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.editProfile,
                        );
                      },
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
                            final preferences =
                                await SharedPreferences.getInstance();
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
            ],
          )),
    );
  }
}
