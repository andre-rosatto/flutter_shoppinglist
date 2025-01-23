import 'package:flutter/material.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:shopping_list/pages/shopping_list_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'ShoppingList',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
      ),
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/list_view': (context) => ShoppingListView(),
    },
  ));
}
