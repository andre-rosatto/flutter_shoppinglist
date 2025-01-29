import 'package:flutter/material.dart';

class CompareItem {
  String title;
  double price = 0.0;
  double amount = 0.0;
  UniqueKey key;

  CompareItem(this.title) : key = UniqueKey();

  CompareItem.fromJson(Map json)
      : title = json['title'],
        price = json['price'],
        amount = json['amount'],
        key = UniqueKey();

  double get pricePerAmount => amount == 0 ? 0 : price / amount;

  Map toJson() => {
        'title': title,
        'price': price,
        'amount': amount,
      };
}
