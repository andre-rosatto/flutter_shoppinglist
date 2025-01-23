import 'package:flutter/material.dart';
import 'package:shopping_list/utils/storage.dart';
import 'package:shopping_list/utils/shopping_item.dart';
import 'package:shopping_list/utils/shopping_list.dart';
import 'package:shopping_list/widgets/add_item_bar.dart';
import 'package:shopping_list/widgets/toggle_input.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  List<ShoppingList> _lists = [];
  int _listIndex = 0;

  void onItemAdded(String text) {
    setState(() {
      _lists[_listIndex].items.insert(0, ShoppingItem(text));
    });
    Storage.saveShoppingLists(_lists);
  }

  void onDeleted(int index) {
    setState(() {
      _lists[_listIndex].items.removeAt(index);
    });
    Storage.saveShoppingLists(_lists);
  }

  void onChanged(int index, String newValue) {
    setState(() {
      _lists[_listIndex].items[index].title = newValue;
    });
    Storage.saveShoppingLists(_lists);
  }

  void onTapped(int index) {
    _lists[_listIndex].items[index].bought =
        !_lists[_listIndex].items[index].bought;
    setState(() {
      sortList();
    });
    Storage.saveShoppingLists(_lists);
  }

  void sortList() {
    _lists[_listIndex].items.sort((a, b) {
      if (!a.bought) return -1;
      if (!b.bought) return 1;
      return 0;
    });
  }

  @override
  void initState() {
    super.initState();
    Storage.loadShoppingLists().then((data) => setState(() => _lists = data));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _listIndex = arguments['listIndex'];
    final List<ShoppingItem> items =
        _lists.isNotEmpty ? _lists[_listIndex].items : [];

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        title: Text('Lista: ${_lists[_listIndex].title}'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          AddItemBar(
            defaultText: 'Novo item',
            onAdded: onItemAdded,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ToggleInput(
                  items[index].title,
                  isComplete: items[index].bought,
                  onDeleted: () => onDeleted(index),
                  onChanged: (newValue) => onChanged(index, newValue),
                  onTapped: () => onTapped(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
