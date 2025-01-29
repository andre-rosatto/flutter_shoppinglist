import 'package:flutter/material.dart';

class NoteItem {
  String text;
  UniqueKey key;

  NoteItem(this.text) : key = UniqueKey();

  NoteItem.fromJson(Map json)
      : text = json['text'],
        key = UniqueKey();

  Map toJson() => {
        'text': text,
      };
}
