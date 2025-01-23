import 'package:flutter/material.dart';
import 'package:shopping_list/utils/compare_item.dart';
import 'package:shopping_list/utils/storage.dart';
import 'package:shopping_list/widgets/add_item_bar.dart';
import 'package:shopping_list/widgets/compare_input.dart';
import 'package:shopping_list/widgets/navbar.dart';

class Compare extends StatefulWidget {
  const Compare({super.key});

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  List<CompareItem> items = [];

  void sortItems() {
    items.sort((a, b) {
      if (a.price == 0) return -1;
      if (b.price == 0) return 1;
      if (a.amount == 0) return -1;
      if (b.amount == 0) return 1;
      return a.pricePerAmount < b.pricePerAmount ? -1 : 1;
    });
  }

  void onItemAdded(String text) {
    setState(() {
      items.insert(0, CompareItem(text));
      Storage.saveCompareList(items);
    });
  }

  void onTitleChanged(int index, String newValue) {
    setState(() {
      items[index].title = newValue;
      Storage.saveCompareList(items);
    });
  }

  void onPriceChanged(int index, double newValue) {
    items[index].price = newValue;
    setState(() {
      sortItems();
      Storage.saveCompareList(items);
    });
  }

  void onAmountChanged(int index, double newValue) {
    items[index].amount = newValue;
    setState(() {
      sortItems();
      Storage.saveCompareList(items);
    });
  }

  void onDeleted(int index) {
    setState(() {
      items.removeAt(index);
      Storage.saveCompareList(items);
    });
  }

  @override
  void initState() {
    super.initState();
    Storage.loadCompareLists().then((data) => setState(() => items = data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        title: Text('Comparar Produtos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          AddItemBar(
            defaultText: 'Novo produto',
            onAdded: onItemAdded,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CompareInput(
                  item: items[index],
                  onTitleChanged: (newValue) => onTitleChanged(index, newValue),
                  onPriceChanged: (newValue) => onPriceChanged(index, newValue),
                  onAmountChanged: (newValue) =>
                      onAmountChanged(index, newValue),
                  onDeleted: () => onDeleted(index),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(index: 1),
    );
  }
}
