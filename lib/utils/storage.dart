import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_list/utils/compare_item.dart';
import 'package:shopping_list/utils/note_item.dart';
import 'package:shopping_list/utils/shopping_list.dart';

class Storage {
  static void saveShoppingLists(List<ShoppingList> lists) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/lists');
    final List<Map> listsMap = lists.map((list) => list.toJson()).toList();
    final String json = jsonEncode(listsMap);
    file.writeAsStringSync(json);
  }

  static Future<List<ShoppingList>> loadShoppingLists() async {
    List<ShoppingList> result = [];
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/lists');
      final String contents = file.readAsStringSync();
      List json = jsonDecode(contents);
      for (int i = 0; i < json.length; i++) {
        result.add(ShoppingList.fromJson(json[i]));
      }
      return result;
    } catch (e) {
      return [];
    }
  }

  static void saveNotes(List<NoteItem> items) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/notes');
    final List<Map> itemsMap = items.map((item) => item.toJson()).toList();
    final String json = jsonEncode(itemsMap);
    file.writeAsStringSync(json);
  }

  static Future<List<NoteItem>> loadNotes() async {
    List<NoteItem> result = [];
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/notes');
      final String contents = file.readAsStringSync();
      List json = jsonDecode(contents);
      for (int i = 0; i < json.length; i++) {
        result.add(NoteItem.fromJson(json[i]));
      }
      return result;
    } catch (e) {
      return [];
    }
  }

  static void saveCompareList(List<CompareItem> items) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/compare_list');
    final List<Map> itemsMap = items.map((item) => item.toJson()).toList();
    final String json = jsonEncode(itemsMap);
    file.writeAsStringSync(json);
  }

  static Future<List<CompareItem>> loadCompareLists() async {
    List<CompareItem> result = [];
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/compare_list');
      final String contents = file.readAsStringSync();
      List json = jsonDecode(contents);
      for (int i = 0; i < json.length; i++) {
        result.add(CompareItem.fromJson(json[i]));
      }
      return result;
    } catch (e) {
      return [];
    }
  }
}
