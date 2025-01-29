import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  final String text;
  final void Function(String newValue) onChanged;
  final void Function() onDeleted;

  const Note(
    this.text, {
    super.key,
    required this.onChanged,
    required this.onDeleted,
  });

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        if (_focusNode.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.onChanged(_controller.text);
        }
      },
      child: Card(
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  maxLines: null,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
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
        ),
      ),
    );
  }
}
