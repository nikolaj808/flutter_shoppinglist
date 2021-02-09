import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/theme.dart';
import 'package:provider/provider.dart';

class ToggleThemeButton extends StatefulWidget {
  @override
  _ToggleThemeButtonState createState() => _ToggleThemeButtonState();
}

class _ToggleThemeButtonState extends State<ToggleThemeButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedSwitcher(
      duration: const Duration(seconds: 5),
      child: themeProvider.isDarkMode
          ? IconButton(
              icon: const Icon(Icons.wb_sunny),
              onPressed: () {
                setState(() {});
                themeProvider.toggleTheme(isOn: !themeProvider.isDarkMode);
              },
            )
          : IconButton(
              icon: const Icon(Icons.bedtime),
              onPressed: () {
                setState(() {});
                themeProvider.toggleTheme(isOn: !themeProvider.isDarkMode);
              },
            ),
    );
  }
}
