class CompareItem {
  String title;
  double price = 0.0;
  double amount = 0.0;

  CompareItem(this.title);

  CompareItem.fromJson(Map json)
      : title = json['title'],
        price = json['price'],
        amount = json['amount'];

  double get pricePerAmount => amount == 0 ? 0 : price / amount;

  Map toJson() => {
        'title': title,
        'price': price,
        'amount': amount,
      };
}
