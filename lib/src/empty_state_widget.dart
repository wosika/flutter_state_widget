import 'package:flutter/widgets.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({Key? key, this.message})
      : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(message ?? "Empty"),
    ]);
  }
}
