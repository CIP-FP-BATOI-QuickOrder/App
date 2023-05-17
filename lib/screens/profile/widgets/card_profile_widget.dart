import 'package:flutter/material.dart';

class CardProfileWidget extends StatelessWidget {
  const CardProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.person_pin_rounded,
              color: Colors.grey,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              'Data Profile',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: Colors.grey,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: const [
              DataProfile(
                icon: Icon(
                  Icons.credit_card,
                  size: 15,
                  color: Colors.white,
                ),
                title: 'User FoodHub',
              ),
              SizedBox(height: 12),
              DataProfile(
                icon: Icon(
                  Icons.email,
                  size: 15,
                  color: Colors.white,
                ),
                title: 'user@foodhub.id',
              ),
              SizedBox(height: 12),
              DataProfile(
                icon: Icon(
                  Icons.phone,
                  size: 15,
                  color: Colors.white,
                ),
                title: '(+62) 221-232-329',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataProfile extends StatelessWidget {

  const DataProfile({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.yellow,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: Colors.orange,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: icon,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
