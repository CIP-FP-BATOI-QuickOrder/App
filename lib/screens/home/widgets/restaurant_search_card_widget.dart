import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/routes.dart';

class RestaurantSearchCardWidget extends StatefulWidget {
  final String name;
  final String pictureId;
  final String city;
  // final dynamic rating;

  const RestaurantSearchCardWidget({
    super.key,
    required this.name,
    required this.pictureId,
    required this.city,
    // required this.rating,
  });

  @override
  State<RestaurantSearchCardWidget> createState() =>
      _RestaurantSearchCardWidgetState();
}

class _RestaurantSearchCardWidgetState
    extends State<RestaurantSearchCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading image');
                    } else {
                      return Image.network('${Routes.apache}${widget.pictureId}',height: 100, width: 120, fit: BoxFit.cover,);
                    }
                  },
                )
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            widget.name,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          'assets/icons/verif.png',
                          width: 13,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.orange,
                          size: 15,
                          shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 5,
                              color: Colors.yellow,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            widget.city,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                          shadows: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 5,
                              color: Colors.yellow,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        SizedBox(width: 4),
                        // Flexible(
                        //   child: Text(
                        //     widget.rating.toString(),
                        //     style: const TextStyle(fontSize: 14),
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/delivery.png',
                            width: 14,
                          ),
                          const SizedBox(width: 4.0),
                          const Flexible(
                            child: Text(
                              'Free delivery',
                              style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Image.asset(
                            'assets/icons/timer.png',
                            width: 10,
                          ),
                          const SizedBox(width: 4.0),
                          const Flexible(
                            child: Text(
                              '10-15 mins',
                              style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
