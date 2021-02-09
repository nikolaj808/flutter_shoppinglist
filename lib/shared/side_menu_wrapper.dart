import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/models/shoppinglist_model.dart';
import 'package:flutter_shoppinglist/personal_shoppinglist/cubit/personal_shoppinglist_cubit.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglists/shoppinglists_bloc.dart';
import 'package:flutter_shoppinglist/providers/repositories/authentication/authentication_repository.dart';
import 'package:flutter_shoppinglist/providers/services/shared_preferences_service.dart';
import 'package:flutter_shoppinglist/theme.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SideMenuWrapper extends StatefulWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  final Widget child;
  final String currentShoppinglistId;

  const SideMenuWrapper({
    Key key,
    @required this.sideMenuKey,
    @required this.child,
    @required this.currentShoppinglistId,
  }) : super(key: key);

  @override
  _HomeScreenSideMenuWrapperState createState() =>
      _HomeScreenSideMenuWrapperState();
}

class _HomeScreenSideMenuWrapperState extends State<SideMenuWrapper> {
  final TextEditingController newShoppinglistController =
      TextEditingController();

  bool isCreatingNew;

  @override
  void initState() {
    super.initState();

    isCreatingNew = false;
  }

  void _onCreateNewShoppinglist(String value) {
    FocusScope.of(context).unfocus();

    if (value.isEmpty) {
      return;
    }

    newShoppinglistController.clear();

    final Shoppinglist shoppinglist = Shoppinglist(
      name: value,
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
      ownerId: AuthenticationRepository().getUserId(),
    );

    BlocProvider.of<ShoppinglistsBloc>(context)
        .add(AddShoppinglist(newShoppinglist: shoppinglist));

    setState(() {
      isCreatingNew = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).themeMode;
    final user = AuthenticationRepository().getUser();

    return SideMenu(
      key: widget.sideMenuKey,
      type: SideMenuType.slideNRotate,
      closeIcon: const Icon(Icons.close),
      background: themeMode == ThemeMode.dark
          ? Theme.of(context).backgroundColor
          : Theme.of(context).scaffoldBackgroundColor,
      menu: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          top: 16.0,
          bottom: 16.0,
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  // TODO: Navigate to profile page
                },
                leading: ClipOval(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(
                      user.photoURL,
                    ),
                  ),
                ),
                title: Text(
                  user.displayName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              BlocBuilder<PersonalShoppinglistCubit, PersonalShoppinglistState>(
                builder: (context, state) {
                  if (state is PersonalShoppinglistLoaded) {
                    return InkWell(
                      onTap: () {
                        if (widget.currentShoppinglistId ==
                            state.personalShoppinglist.id) {
                          return;
                        }

                        SharedPreferencesService.setString(
                          SharedPreferencesKey.previousList,
                          state.personalShoppinglist.id,
                        );

                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/personal',
                          (_) => false,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.personalShoppinglist.name,
                          style: widget.currentShoppinglistId ==
                                  state.personalShoppinglist.id
                              ? Theme.of(context).textTheme.headline5.copyWith(
                                  color: Theme.of(context).primaryColor)
                              : Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    );
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const LinearProgressIndicator(),
                  );
                },
              ),
              if (isCreatingNew)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: newShoppinglistController,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    onFieldSubmitted: _onCreateNewShoppinglist,
                  ),
                )
              else
                FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      isCreatingNew = true;
                    });
                  },
                  textTheme: ButtonTextTheme.accent,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Tilføj ny liste',
                  ),
                ),
              Expanded(
                child: BlocBuilder<ShoppinglistsBloc, ShoppinglistsState>(
                  builder: (context, state) {
                    if (state is ShoppinglistsLoaded) {
                      final shoppinglists = state.shoppinglists;

                      return ListView.builder(
                        itemCount: shoppinglists.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            if (widget.currentShoppinglistId ==
                                shoppinglists[index].id) {
                              return;
                            }

                            SharedPreferencesService.setString(
                              SharedPreferencesKey.previousList,
                              shoppinglists[index].id,
                            );

                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/shoppinglist',
                              (_) => false,
                              arguments: shoppinglists[index].id,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              shoppinglists[index].name,
                              style: widget.currentShoppinglistId ==
                                      shoppinglists[index].id
                                  ? Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Theme.of(context).primaryColor)
                                  : Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    SharedPreferencesService.clear(
                      SharedPreferencesKey.previousList,
                    );
                    AuthenticationRepository().logOut();
                  } finally {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login',
                      (_) => false,
                    );
                  }
                },
                child: Text(
                  'Log ud',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
