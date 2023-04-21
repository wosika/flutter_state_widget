import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      const CircularProgressIndicator(),
      const SizedBox(height: 20),
      Text(message ?? "Loading")
    ]);
  }
}
