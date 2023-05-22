import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final dynamic rating;
  final double fontSizeRating, fontSizeReview, iconSize, paddingRounded;

  const RatingWidget({
    super.key,
    required this.rating,
    this.fontSizeRating = 14,
    this.fontSizeReview = 10,
    this.iconSize = 18,
    this.paddingRounded = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingRounded),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rating.toString(),
            style: TextStyle(
              fontSize: fontSizeRating,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4.0),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: iconSize,
          ),
        ],
      ),
    );
  }
}
