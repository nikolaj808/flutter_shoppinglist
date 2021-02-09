import 'package:flutter/material.dart';

class ItemsLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Flexible(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
