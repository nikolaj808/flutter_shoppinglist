import 'package:flutter/material.dart';

class EditGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Hey'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('There'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
