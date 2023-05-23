import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/home/widgets/rating_widget.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';
import '../../../provider/user_provider.dart';

class RestaurantCardWidget extends StatefulWidget {
  final int id;
  final String name;
  final String city;
  final String pictureId;
  final int deliveryTime;
  final int deliveryPrice;
  final List<String> tags;
  final double rating;
  final int userId;

  const RestaurantCardWidget(
      {super.key,
      required this.id,
      required this.name,
      required this.city,
      required this.pictureId,
      required this.deliveryTime,
      required this.deliveryPrice,
      required this.tags,
      required this.rating,
      required this.userId});

  @override
  State<RestaurantCardWidget> createState() => _RestaurantCardWidgetState();
}

class _RestaurantCardWidgetState extends State<RestaurantCardWidget> {
  bool _isFavorite = false;

  User? getUser() {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.user;
  }

  Future<bool> addToFavorites() async {
    final response =
        await http.get(Uri.parse("${Routes.api}favorites/add/user=${widget.userId}/restaurant=${widget.id}"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeFromFavorites() async {
    final response = await http
        .get(Uri.parse("${Routes.api}favorites/remove/user=${widget.userId}/restaurant=${widget.id}"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void isFavorite() async {
    final response =
        await http.get(Uri.parse("${Routes.api}favorites/user=${widget.userId}/restaurant=${widget.id}"));
    if (response.statusCode == 200) {
      setState(() {
        _isFavorite = true;
      });
    } else {
      setState(() {
        _isFavorite = false;
      });
    }
  }

  @override
  void initState() {
    isFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;
    final cardWidth = isPortrait
        ? 280.0
        : 320.0; // Ancho máximo del widget según la orientación

    return Container(
      constraints: BoxConstraints(
        maxWidth: cardWidth,
      ),
      width: size.width - 90,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 149,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error loading image');
                            } else {
                              return Image.network(
                                  '${Routes.apache}${widget.pictureId}',
                                  fit: BoxFit.fill);
                            }
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingWidget(
                          rating: widget.rating,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.orange,
                          onTap: () async {
                            if (!_isFavorite) {
                              addToFavorites();
                              context.showCustomFlashMessage(
                                status: 'success',
                                title: 'Success Add Favorite',
                                positionBottom: false,
                                message: 'Add ${widget.name} to your Favorite',
                              );
                            } else {
                              removeFromFavorites();
                              context.showCustomFlashMessage(
                                status: 'success',
                                title: 'Success remove Favorite',
                                positionBottom: false,
                                message: 'Add ${widget.name} to your Favorite',
                              );
                            }
                            setState(() {
                             _isFavorite = !_isFavorite;
                            });
                          },
                          child: _isFavorite
                              ? Card(
                                  color: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Card(
                                  color: Colors.grey.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
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
                    const SizedBox(height: 11.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/delivery.png',
                          width: 14,
                        ),
                        const SizedBox(width: 4.0),
                        Flexible(
                          child: Text(
                            "${widget.deliveryPrice} €",
                            style: const TextStyle(
                              color: Colors.black26,
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
                        Flexible(
                          child: Text(
                            '${widget.deliveryTime} mins',
                            style: const TextStyle(
                              color: Colors.black26,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: widget.tags.map((tagName) {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey.withOpacity(0.15),
                          ),
                          child: Text(
                            tagName,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
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
