import 'package:flutter/material.dart';

class DetailSection extends StatelessWidget {
  final String title;
  final String body;

  const DetailSection({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(body),
    );
  }
}
