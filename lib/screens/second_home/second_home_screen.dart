import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/screens/second_home/widgets/drawer_view_widget.dart';
import 'package:flutter_shoppinglist/screens/second_home/widgets/home_view_widget.dart';

class SecondHomeScreen extends StatefulWidget {
  @override
  _SecondHomeScreenState createState() => _SecondHomeScreenState();
}

class _SecondHomeScreenState extends State<SecondHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            DrawerViewWidget(),
            HomeViewWidget(),
          ],
        ),
      ),
    );
  }
}
