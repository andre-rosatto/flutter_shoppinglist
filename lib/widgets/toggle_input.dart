import 'package:flutter/material.dart';

class ToggleInput extends StatefulWidget {
  final String text;
  final bool isComplete;
  final void Function() onDeleted;
  final void Function(String newValue) onChanged;
  final void Function() onTapped;

  const ToggleInput(
    this.text, {
    super.key,
    required this.isComplete,
    required this.onDeleted,
    required this.onChanged,
    required this.onTapped,
  });

  @override
  State<ToggleInput> createState() => _ToggleInputState();
}

class _ToggleInputState extends State<ToggleInput> {
  final TextEditingController _controller = TextEditingController();
  bool isEditing = false;

  void onFocusLost() {
    setState(() {
      isEditing = false;
      widget.onChanged(_controller.text);
    });
  }

  Widget getWidget() {
    return isEditing
        ? Expanded(
            child: Expanded(
              child: FocusScope(
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    _controller.selection = TextSelection(
                        baseOffset: 0, extentOffset: _controller.text.length);
                  } else {
                    onFocusLost();
                  }
                },
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.0,
                      ),
                    ),
                  ),
                  onTapOutside: (event) => onFocusLost(),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: widget.onTapped,
            onLongPress: () {
              setState(() {
                _controller.text = widget.text;
                isEditing = true;
              });
            },
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.isComplete
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onSurface,
                decorationColor: widget.isComplete
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 18.0,
                decoration: widget.isComplete
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10.0),
          if (widget.isComplete) Icon(Icons.check),
          if (!isEditing) SizedBox(width: 10.0),
          Expanded(
            child: getWidget(),
          ),
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
    );
  }
}
