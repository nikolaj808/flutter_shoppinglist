import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/screens/second_home/widgets/list_item_widget.dart';

class HomeViewWidget extends StatefulWidget {
  @override
  _HomeViewWidgetState createState() => _HomeViewWidgetState();
}

class _HomeViewWidgetState extends State<HomeViewWidget> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  _toggleDrawer() {
    isDrawerOpen ? _closeDrawer() : _openDrawer();
  }

  _closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      isDrawerOpen = false;
    });
  }

  _openDrawer() {
    setState(() {
      xOffset = 290;
      yOffset = 80;
      isDrawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _closeDrawer();
      },
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? -50 : 0),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius:
              isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.zero,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .primaryIconTheme
                          .color
                          .withOpacity(0.05),
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(40)
                      : BorderRadius.zero,
                ),
                // color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        isDrawerOpen ? Icons.arrow_back : Icons.menu,
                      ),
                      onTap: () {
                        _toggleDrawer();
                      },
                    ),
                    Text(
                      'Random Shopping List',
                      style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color,
                        fontSize: 24,
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.settings),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  ListItemWidget(
                    id: '1',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '2',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '3',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '4',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '5',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '6',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '7',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '8',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '9',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '10',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                  ListItemWidget(
                    id: '11',
                    name: 'Rød pesto',
                    quantity: 5,
                    onDismissed: (_) {},
                    onIncreaseQuantity: () async => print('Up'),
                    onDecreaseQuantity: () async => print('Down'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
