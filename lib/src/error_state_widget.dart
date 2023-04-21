import 'package:flutter/widgets.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({Key? key, this.onRetry, this.message})
      : super(key: key);
  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
