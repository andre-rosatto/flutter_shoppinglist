import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shopping_list/utils/storage.dart';
import 'package:shopping_list/utils/shopping_list.dart';
import 'package:shopping_list/widgets/add_item_bar.dart';
import 'package:shopping_list/widgets/navbar.dart';
import 'package:shopping_list/widgets/toggle_input.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String storagePath = '';
  List<ShoppingList> _lists = [];

  void onItemAdded(String text) {
    setState(() {
      _lists.insert(0, ShoppingList(text));
      Storage.saveShoppingLists(_lists);
    });
  }

  void onDeleted(int index) {
    setState(() {
      _lists.removeAt(index);
    });
    Storage.saveShoppingLists(_lists);
  }

  void onChanged(int index, String newValue) {
    setState(() {
      _lists[index].title = newValue;
    });
    Storage.saveShoppingLists(_lists);
  }

  void onTapped(int index) async {
    await Navigator.pushNamed(context, '/list_view',
        arguments: {'listIndex': index});
    Storage.loadShoppingLists().then((data) => setState(() => _lists = data));
  }

  String getDate() {
    initializeDateFormatting(Platform.localeName);
    DateTime now = DateTime.now();
    return DateFormat.yMd(Platform.localeName).format(now);
  }

  @override
  void initState() {
    super.initState();
    Storage.loadShoppingLists().then((data) => setState(() => _lists = data));
  }

  @override
  Widget build(BuildContext context) {
    final String date = getDate();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        title: Text('ShoppingList'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          AddItemBar(
            defaultText: date,
            onAdded: onItemAdded,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _lists.length,
              itemBuilder: (context, index) {
                return ToggleInput(
                  _lists[index].title,
                  isComplete: _lists[index].isComplete,
                  onDeleted: () => onDeleted(index),
                  onChanged: (newValue) => onChanged(index, newValue),
                  onTapped: () => onTapped(index),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(index: 0),
    );
  }
}
