import 'package:flutter/material.dart';

class ShoppingItem {
  String title;
  bool bought = false;
  UniqueKey key;

  ShoppingItem(this.title) : key = UniqueKey();

  ShoppingItem.fromJson(Map json)
      : title = json['title'],
        bought = json['bought'],
        key = UniqueKey();

  Map toJson() => {
        'title': title,
        'bought': bought,
      };
}
