import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  List<String> _items = [];

  @override
  Future<void> addItem(String item) async {
    _items.add(item);
    await _saveItem();
  }

  @override
  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
    await _removeItem();
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    _items[index] = newItem;
    await _saveItem();
  }

  @override
  Future<List<String>> getItems() async {
    _items = await prefs.getStringList("tasks") ?? [];
    return _items;
  }

  @override
  Future<int> get itemCount async {
    await getItems();
    return _items.length;
  }

  // Function to save Tasks

  Future<void> _saveItem() async {
    await prefs.setStringList("tasks", _items);
  }

  // Function to remove a Task

  Future<void> _removeItem() async {
    await prefs.remove("tasks");
  }
}
