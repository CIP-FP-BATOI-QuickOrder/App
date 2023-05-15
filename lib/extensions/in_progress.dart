import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void showCustomFlashMessage({
    String title = 'Coming Soon!',
    String message = 'We will notify you once this feature is ready 🙌',
    bool positionBottom = true,
    required String status,
  }) {
    showFlash(
      context: this,
      duration: const Duration(seconds: 2),
      builder: (_, controller) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Flash(
            controller: controller,
            behavior: FlashBehavior.floating,
            position: positionBottom ? FlashPosition.bottom : FlashPosition.top,
            borderRadius: BorderRadius.circular(8.0),
            backgroundGradient: const LinearGradient(
              colors: [
                Colors.white,
                Colors.grey,
              ],
            ),
            forwardAnimationCurve: Curves.easeInCirc,
            reverseAnimationCurve: Curves.easeOutBack,
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.orange),
              child: FlashBar(
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                content: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: Icon(
                  status.toLowerCase() == 'success'
                      ? Icons.check_circle
                      : status == 'failed'
                      ? Icons.warning_rounded
                      : Icons.info,
                ),
                primaryAction: TextButton(
                  onPressed: () => controller.dismiss(),
                  child: const Text(
                    'DISMISS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ThemeData get theme => Theme.of(this);
}
