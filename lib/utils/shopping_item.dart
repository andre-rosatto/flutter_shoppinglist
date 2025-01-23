class ShoppingItem {
  String title;
  bool bought = false;

  ShoppingItem(this.title);

  ShoppingItem.fromJson(Map json)
      : title = json['title'],
        bought = json['bought'];

  Map toJson() => {
        'title': title,
        'bought': bought,
      };
}
