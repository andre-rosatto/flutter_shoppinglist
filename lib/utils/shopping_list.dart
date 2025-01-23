import 'package:shopping_list/utils/shopping_item.dart';

class ShoppingList {
  String title;
  List<ShoppingItem> items = [];

  ShoppingList(this.title);

  ShoppingList.fromJson(Map json) : title = json['title'] {
    List jsonItems = json['items'];
    items = jsonItems.map((item) => ShoppingItem.fromJson(item)).toList();
  }

  Map toJson() => {
        'title': title,
        'items': items.map((item) => item.toJson()).toList(),
      };

  bool get isComplete {
    return items.isNotEmpty && items.every((item) => item.bought);
  }
}
