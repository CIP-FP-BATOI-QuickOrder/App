import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'package:quick_order/screens/Workers/edit_product/widget/edit_product_form_widget.dart';
import 'package:http/http.dart' as http;

import '../../../models/product.dart';
import '../../../routes/routes.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../welcome/widgets/signing_button.dart';

class NewProductContent extends StatefulWidget {
  NewProductContent({super.key, required this.provider});

  WorkerRestaurantProvider provider;

  @override
  State<NewProductContent> createState() => _NewProductContentState();
}

class _NewProductContentState extends State<NewProductContent> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _description;
  late TextEditingController _price;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();
  }

  Uint8List? pickedImageBytes;
  late PickedFile file;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final pickedFile = await pickedImage.readAsBytes();
      file = pickedImage;
      setState(() {
        pickedImageBytes = pickedFile;
      });
    }
  }

  Future<void> _checkPermissionAndPickImage() async {
    if (await Permission.camera.request().isGranted) {
      _pickImageFromGallery();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 28.0),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: _checkPermissionAndPickImage,
                  child: pickedImageBytes != null
                      ? Image.memory(
                          pickedImageBytes!,
                          height: 200,
                          width: 220,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '${Routes.apache}product.png',
                          height: 200,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 28.0),
              EditProductFormWidget(
                nameController: _name,
                descriptionController: _description,
                priceController: _price,
              ),
              ButtonWidget(
                onPress: () async {
                  Product product = Product(
                      photo: path.basename(file.path),
                      id: 0,
                      description: _description.text,
                      name: _name.text,
                      price: double.parse(_price.text));
                  widget.provider.saveProduct(product, file);
                    context.showCustomFlashMessage(
                      status: "success",
                      title: "Created",
                      positionBottom: false,
                      message: "${product.name} was created"
                    );
                  Future.delayed(const Duration(seconds: 1)).then((value) => Navigator.pushNamed(context, Routes.workersHome, arguments: widget.provider));
                },
                title: 'SAVE',
                buttonColor: Colors.orange,
                titleColor: Colors.white,
                borderColor: Colors.orange,
                paddingHorizontal: 22.0,
                paddingVertical: 22.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
