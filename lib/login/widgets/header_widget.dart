import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 80.0),
              child: Text(
                'PERSONAL',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 42.0,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 16.0,
                      offset: Offset(8.0, 8.0),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80.0),
              child: Text(
                'SHOPPER',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 42.0,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 16.0,
                      offset: Offset(-8.0, 8.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
