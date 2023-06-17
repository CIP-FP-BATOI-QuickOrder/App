import 'package:flutter/material.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';

import 'login_content.dart';

class WorkersLoginScreen extends StatelessWidget {
  WorkersLoginScreen({super.key, required this.provider});

  WorkerRestaurantProvider provider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: WorkersLoginContent(
              provider: provider,
            ),
          ),
        ),
      ),
    );
  }
}
