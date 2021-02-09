import 'package:flutter/material.dart';

class ItemsErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Der skete en fejl'),
            TextButton(
              onPressed: () {
                // TODO: Reload items
              },
              child: const Text('Genindlæs siden'),
            ),
          ],
        ),
      ),
    );
  }
}
