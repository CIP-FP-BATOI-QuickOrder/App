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

class EditProductContent extends StatefulWidget {
  EditProductContent(
      {super.key, required this.provider, required this.product});

  WorkerRestaurantProvider provider;
  Product product;

  @override
  State<EditProductContent> createState() => _EditProductContentState();
}

class _EditProductContentState extends State<EditProductContent> {
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

    _name.text = widget.product.name;
    _description.text = widget.product.description;
    _price.text = widget.product.price.toStringAsFixed(2);
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
                    '${Routes.apache}${widget.product.photo}',
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
                  widget.product.price = double.parse(_price.text);
                  widget.product.description = _description.text;
                  widget.product.name = _name.text;
                  widget.provider.updateProduct(widget.product);
                  if(pickedImageBytes != null){
                    widget.provider.upgradeProductPhoto(file, widget.product.id);
                  }
                  context.showCustomFlashMessage(
                    status: "success",
                    title: "Edited",
                    positionBottom: false,
                    message: "${widget.product.name} was edited"
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
