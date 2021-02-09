import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_shoppinglist/edit_group/edit_group_screen.dart';
import 'package:flutter_shoppinglist/settings/settings_screen.dart';
import 'package:flutter_shoppinglist/shared/toggle_theme_button_widget.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  final String shoppinglistId;
  final bool isPersonalShoppinglist;

  const SearchAppBar({
    Key key,
    @required this.sideMenuKey,
    @required this.shoppinglistId,
    this.isPersonalShoppinglist = false,
  }) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _SearchAppBarState extends State<SearchAppBar> {
  String currentQuery = '';
  SearchBar searchBar;

  _SearchAppBarState() {
    searchBar = SearchBar(
      onChanged: (value) => currentQuery = value,
      clearOnSubmit: false,
      setState: setState,
      buildDefaultAppBar: buildAppBar,
      onCleared: _onClear,
      onSubmitted: _onSubmit,
      hintText: 'Søg...',
      inBar: false,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _onClear() => setState(() => currentQuery = '');

  void _onSubmit(String query) => setState(() => currentQuery = query);

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        currentQuery.isEmpty ? '' : 'Søger efter: $currentQuery',
        style: Theme.of(context).textTheme.caption,
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          final _state = widget.sideMenuKey.currentState;
          if (_state.isOpened) {
            _state.closeSideMenu();
          } else {
            _state.openSideMenu();
          }
        },
      ),
      actions: [
        if (!widget.isPersonalShoppinglist)
          OpenContainer(
            closedBuilder: (_, __) => IconButton(
              icon: Icon(
                Icons.group_add,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onPressed: null,
            ),
            closedElevation: 0,
            closedColor: Theme.of(context).scaffoldBackgroundColor,
            openBuilder: (_, __) => EditGroupScreen(),
          ),
        if (!widget.isPersonalShoppinglist)
          OpenContainer(
            closedBuilder: (_, __) => IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onPressed: null,
            ),
            closedElevation: 0,
            closedColor: Theme.of(context).scaffoldBackgroundColor,
            openBuilder: (_, __) => SettingsScreen(shoppinglistId: widget.shoppinglistId),
          ),
        ToggleThemeButton(),
        searchBar.getSearchAction(context),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return searchBar.build(context);
  }
}
