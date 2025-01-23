import 'package:flutter/material.dart';

class AddItemBar extends StatefulWidget {
  const AddItemBar({
    super.key,
    required this.defaultText,
    required this.onAdded,
  });

  final String defaultText;
  final void Function(String text) onAdded;

  @override
  State<AddItemBar> createState() => _AddItemBarState();
}

class _AddItemBarState extends State<AddItemBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.defaultText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onAdded(_controller.text.isEmpty
                ? widget.defaultText
                : _controller.text);
            _controller.clear();
          },
          icon: Icon(
            Icons.add_circle_outline,
            size: 40.0,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
