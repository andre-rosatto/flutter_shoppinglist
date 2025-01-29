import 'package:flutter/material.dart';
import 'package:shopping_list/utils/note_item.dart';
import 'package:shopping_list/utils/storage.dart';
import 'package:shopping_list/widgets/navbar.dart';
import 'package:shopping_list/widgets/note.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<NoteItem> _notes = [];

  void onChanged(int index, String newValue) {
    setState(() {
      _notes[index].text = newValue;
    });
    Storage.saveNotes(_notes);
  }

  void onDeleted(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    Storage.loadNotes().then((data) => setState(() => _notes = data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        title: Text('Anotações'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return Note(
            _notes[index].text,
            key: _notes[index].key,
            onChanged: (newValue) => onChanged(index, newValue),
            onDeleted: () => onDeleted(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        onPressed: () {
          setState(() {
            _notes.insert(0, NoteItem(''));
          });
          Storage.saveNotes(_notes);
        },
      ),
      bottomNavigationBar: Navbar(index: 1),
    );
  }
}
