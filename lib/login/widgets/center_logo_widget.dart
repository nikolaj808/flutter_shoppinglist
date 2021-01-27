import 'package:flutter/material.dart';

class CenterLogoWidget extends StatelessWidget {
  const CenterLogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: const Size(200, 200),
        child: Image.asset('assets/shopping-cart.png'),
      ),
    );
  }
}
