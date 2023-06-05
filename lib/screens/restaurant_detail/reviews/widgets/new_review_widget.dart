import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/models/order_line.dart';
import 'package:quick_order/models/review.dart';
import 'package:quick_order/provider/review_provider.dart';
import 'package:quick_order/screens/welcome/widgets/signing_button.dart';
import 'package:http/http.dart' as http;

import '../../../../models/restaurant.dart';
import '../../../../models/user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../routes/routes.dart';

class NewReview extends StatefulWidget {
  final ReviewProvider reviewProvider;

  const NewReview({Key? key, required this.reviewProvider}) : super(key: key);

  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  int qty = 1;
  double containerHeight = 200;
  bool isKeyboardVisible = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isKeyboardVisible = _focusNode.hasFocus;
      if (isKeyboardVisible) {
        containerHeight = 500;
      } else {
        containerHeight = 200;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController reviewController = TextEditingController();
    return Container(
      height: containerHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 6,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.orange,
            ),
          ),
          Column(
            children: [
              TextFormField(
                focusNode: _focusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Review can\'t be empty.';
                  }
                  return null;
                },
                controller: reviewController,
                decoration: InputDecoration(
                  hintText: "Write new review",
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
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              widget.reviewProvider.sendReview(reviewController.text);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                width: 1.0,
                color: Colors.orange,
              ),
              backgroundColor: Colors.orange,
              alignment: Alignment.center,
              shadowColor: Colors.black26,
              elevation: 5,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 35,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              "Send review",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
