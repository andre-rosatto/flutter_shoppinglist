import 'package:flutter/material.dart';
import 'package:shopping_list/utils/compare_item.dart';

class CompareInput extends StatefulWidget {
  final CompareItem item;
  final void Function(String newValue) onTitleChanged;
  final void Function(double newValue) onPriceChanged;
  final void Function(double newValue) onAmountChanged;
  final void Function() onDeleted;

  const CompareInput({
    super.key,
    required this.item,
    required this.onTitleChanged,
    required this.onPriceChanged,
    required this.onAmountChanged,
    required this.onDeleted,
  });

  @override
  State<CompareInput> createState() => _CompareInputState();
}

class _CompareInputState extends State<CompareInput> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  double formatNumber(String value) {
    String formatted = value.replaceAll(',', '.');
    RegExp exp = RegExp(r'[^0-9^\.]');
    formatted = formatted.replaceAllMapped(exp, (match) => '');
    return double.tryParse(formatted) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.item.title;
    _priceController.text = widget.item.price.toStringAsFixed(2);
    _amountController.text = widget.item.amount.toStringAsFixed(2);

    void onTitleFocusLost() {
      widget.onTitleChanged(_titleController.text);
    }

    void onPriceFocusLost() {
      widget.onPriceChanged(formatNumber(_priceController.text));
    }

    void onAmountFocusLost() {
      widget.onAmountChanged(formatNumber(_amountController.text));
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  FocusScope(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        _titleController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _titleController.text.length);
                      } else {
                        onTitleFocusLost();
                      }
                    },
                    child: TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onTapOutside: (event) => onTitleFocusLost(),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preço',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              FocusScope(
                                onFocusChange: (hasFocus) {
                                  if (hasFocus) {
                                    _priceController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _priceController.text.length);
                                  } else {
                                    onPriceFocusLost();
                                  }
                                },
                                child: TextField(
                                  controller: _priceController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: widget.item.price == 0
                                            ? Colors.red
                                            : Theme.of(context)
                                                .colorScheme
                                                .outline,
                                      ),
                                    ),
                                  ),
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    onPriceFocusLost();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantidade',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              FocusScope(
                                onFocusChange: (hasFocus) {
                                  if (hasFocus) {
                                    _amountController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _amountController.text.length);
                                  } else {
                                    onAmountFocusLost();
                                  }
                                },
                                child: TextField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: widget.item.amount == 0
                                            ? Colors.red
                                            : Theme.of(context)
                                                .colorScheme
                                                .outline,
                                      ),
                                    ),
                                  ),
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    onAmountFocusLost();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preço/Quant.',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  widget.item.pricePerAmount.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            IconButton(
              onPressed: widget.onDeleted,
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
