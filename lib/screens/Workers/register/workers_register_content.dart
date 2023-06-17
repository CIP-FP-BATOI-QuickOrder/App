import 'dart:ffi';
import 'dart:io';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/restaurant.dart';
import 'package:quick_order/screens/Workers/register/widgets/workers_register_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../../provider/worker_restaurant_provider.dart';
import '../../../routes/routes.dart';
import '../../welcome/widgets/signing_button.dart';
import '../../welcome/widgets/social_media_buttons.dart';

class WorkersRegisterContent extends StatefulWidget {
  WorkersRegisterContent({Key? key, required this.provider}) : super(key: key);

  WorkerRestaurantProvider provider;

  @override
  State<WorkersRegisterContent> createState() => _WorkersRegisterContentState();
}

class _WorkersRegisterContentState extends State<WorkersRegisterContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _nif;
  late TextEditingController _password;
  late TextEditingController _photo;
  late TextEditingController _city;
  late TextEditingController _direction;
  late TextEditingController _deliveryTime;
  late TextEditingController _deliveryPrice;
  late TextEditingController _tags;
  late PickedFile pickedFile;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _nif = TextEditingController();
    _password = TextEditingController();
    _photo = TextEditingController();
    _city = TextEditingController();
    _direction = TextEditingController();
    _deliveryPrice = TextEditingController();
    _deliveryTime = TextEditingController();
    _tags = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _nif.dispose();
    _password.dispose();
    _photo.dispose();
    _city.dispose();
    _direction.dispose();
    _deliveryPrice.dispose();
    _deliveryTime.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      pickedFile = pickedImage;
    }
  }

  Future<void> sendPhoto(String url, PickedFile file) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final fileMultipart = await http.MultipartFile.fromPath('photo', file.path,
        contentType: MediaType('image', 'jpeg'));

    request.files.add(fileMultipart);

    await request.send();
  }

  Future<void> _checkPermissionAndPickImage() async {
    if (await Permission.camera.request().isGranted) {
      _pickImageFromGallery();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      ],
                    ),
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
                  'Restaurant Sign Up',
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 38.0),
                Form(
                  key: _formState,
                  child: WorkersRegisterFormWidget(
                    name: _name,
                    city: _city,
                    deliveryTime: _deliveryTime,
                    deliveryPrice: _deliveryPrice,
                    direction: _direction,
                    nif: _nif,
                    password: _password,
                    photo: _photo,
                    tags: _tags,
                  ),
                ),
                const SizedBox(height: 28.0),
                ButtonWidget(
                  onPress: _checkPermissionAndPickImage,
                  title: "Pick photo",
                  buttonColor: Colors.orange,
                  titleColor: Colors.white,
                  borderColor: Colors.orange,
                  paddingHorizontal: 22.0,
                  paddingVertical: 22.0,
                ),
                const SizedBox(height: 28.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42.0),
                  child: ButtonWidget(
                    onPress: () async {
                      List<String> tagsList = _tags.text.split(' ');
                      List<String> trimmedTags = tagsList
                          .where((element) => element.isNotEmpty)
                          .toList();
                      Restaurant restaurant = Restaurant(
                          id: 0,
                          name: _name.text,
                          nif: _nif.text,
                          password: _password.text,
                          photo: "",
                          city: _city.text,
                          direction: _direction.text,
                          deliveryPrice: int.parse(_deliveryPrice.text),
                          deliveryTime: int.parse(_deliveryTime.text),
                          rating: 0,
                          tags: trimmedTags);

                      if (await widget.provider.register(restaurant)) {
                        widget.provider.upgradePhoto(pickedFile);
                        Navigator.pushNamed(
                          context,
                          Routes.workersLogin,
                          arguments: widget.provider
                        );
                      } else {
                        context.showCustomFlashMessage(
                            status: 'failed',
                            positionBottom: false,
                            message: "Something went wrong\n"
                                "Check your nif",
                            title: "Error");
                      }
                    },
                    title: 'SIGN UP',
                    buttonColor: Colors.orange,
                    titleColor: Colors.white,
                    borderColor: Colors.orange,
                    paddingHorizontal: 22.0,
                    paddingVertical: 22.0,
                  ),
                ),
                const SizedBox(height: 36.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, Routes.workersLogin,
                          arguments: widget.provider),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orange,
                          decorationThickness: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: Text(
                          'sign up with',
                          style: TextStyle(color: Colors.black26),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18.0),
                const ButtonSigninWith(
                  positionButtom: false,
                ),
                const SizedBox(height: 18.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
