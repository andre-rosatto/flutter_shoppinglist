import 'package:flutter/material.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:shopping_list/pages/shopping_list_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'ShoppingList',
    theme: ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.purple,
        onPrimary: Colors.white,
        secondary: Colors.grey,
        onSecondary: Colors.grey,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
    ),
    darkTheme: ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromRGBO(150, 0, 90, 1),
        onPrimary: Colors.white,
        secondary: Colors.grey,
        onSecondary: Color.fromRGBO(255, 255, 255, 0.5),
        error: Colors.red,
        onError: Colors.black,
        surface: Color.fromRGBO(50, 50, 50, 1),
        onSurface: Color.fromRGBO(200, 200, 200, 1),
      ),
    ),
    themeMode: ThemeMode.system,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/list_view': (context) => ShoppingListView(),
    },
  ));
}
