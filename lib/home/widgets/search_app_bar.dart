import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_shoppinglist/home/widgets/toggle_theme_button_widget.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglist/shoppinglist_bloc.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<SideMenuState> sideMenuKey;

  const SearchAppBar({
    Key key,
    @required this.sideMenuKey,
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
            BlocProvider.of<ShoppinglistBloc>(context).add(GetShoppinglists());
          }
        },
      ),
      actions: [
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
