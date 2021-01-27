import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeScreenSideMenuWrapper extends StatelessWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  final Widget child;

  const HomeScreenSideMenuWrapper({
    Key key,
    this.sideMenuKey,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: sideMenuKey,
      type: SideMenuType.slideNRotate,
      closeIcon: const Icon(Icons.close),
      background: Theme.of(context).backgroundColor,
      menu: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          top: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton.icon(
              onPressed: () {},
              textTheme: ButtonTextTheme.primary,
              icon: const Icon(Icons.add),
              label: const Text(
                'Tilføj ny liste',
              ),
            ),
            Expanded(
              child: BlocBuilder<ShoppinglistBloc, ShoppinglistState>(
                builder: (context, state) {
                  if (state is ShoppinglistsLoaded) {
                    return StreamBuilder(
                      stream: state.shoppinglists,
                      initialData: [],
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return ListView.builder(
                          itemCount: (snapshot.data as List).length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].name as String,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Log ud',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
