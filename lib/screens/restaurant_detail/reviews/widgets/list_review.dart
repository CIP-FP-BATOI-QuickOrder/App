import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';

class ReviewCardWidget extends StatelessWidget {
  final String name;
  final String review;
  final String date;
  final String photo;

  const ReviewCardWidget({
    super.key,
    required this.name,
    required this.review,
    required this.date,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading image');
                      } else {
                        return CircleAvatar(
                          backgroundImage:
                              NetworkImage('${Routes.apache}$photo'),
                          radius: 15,
                        );
                      }
                    },
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.orange,
                  ),
                  maxLines: 5,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              review,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
