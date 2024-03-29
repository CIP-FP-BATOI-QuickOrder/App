import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../routes/routes.dart';

class CardSettingWidget extends StatefulWidget {
  const CardSettingWidget({Key? key}) : super(key: key);

  @override
  _CardSettingWidgetState createState() => _CardSettingWidgetState();
}

class _CardSettingWidgetState extends State<CardSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.settings,
              color: Colors.grey,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              'Setting',
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
            children: [
               DataSetting(
                icon: const Icon(
                  Icons.house,
                  size: 15,
                  color: Colors.white,
                ),
                title: 'Shipping addresses', onTap: () {
                 Navigator.pushNamed(
                   context,
                   Routes.addresses,
                 );
               },
              ),
              const SizedBox(height: 10),
               DataSetting(
                icon: const Icon(
                  Icons.credit_card,
                  size: 15,
                  color: Colors.white,
                ),
                title: 'Payment methods', onTap: () {
                 Navigator.pushNamed(
                   context,
                   Routes.payment,
                 );
               },
              ),
              const SizedBox(height: 10),
              DataSetting(
                icon: const Icon(
                  Icons.history,
                  size: 15,
                  color: Colors.white,
                ),
                title: 'History', onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.history,
                );
              },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataSetting extends StatelessWidget {
  const DataSetting({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.orange,
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          const SizedBox(
            width: 40,
            height: 32,
            child: FittedBox(
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
