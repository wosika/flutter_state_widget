import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({Key? key, this.onRetry, this.message})
      : super(key: key);
  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(message ?? "Error"),
      const SizedBox(height: 20),
      TextButton.icon(
        style: TextButton.styleFrom(),
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text("Retry"))
    ]);
  }
}
