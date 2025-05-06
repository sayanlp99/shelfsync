import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'inventory_model.dart';

class InventoryService {
  final String className = 'Inventory';

  Future<List<InventoryItem>> getItems() async {
    final query = QueryBuilder<ParseObject>(ParseObject(className));
    final response = await query.query();
    if (response.success && response.results != null) {
      return (response.results as List)
          .map((e) => InventoryItem.fromParse(e.toJson()))
          .toList();
    } else {
      throw Exception('Failed to load inventory');
    }
  }

  Future<void> addItem(InventoryItem item) async {
    final parseObject = ParseObject(className);
    item.toParse().forEach((key, value) {
      parseObject.set(key, value);
    });
    final response = await parseObject.save();
    if (!response.success) {
      throw Exception('Failed to add item');
    }
  }

  Future<void> updateItem(InventoryItem item) async {
    final parseObject = ParseObject(className)..objectId = item.id;
    item.toParse().forEach((key, value) {
      parseObject.set(key, value);
    });
    final response = await parseObject.save();
    if (!response.success) {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(String id) async {
    final parseObject = ParseObject(className)..objectId = id;
    final response = await parseObject.delete();
    if (!response.success) {
      throw Exception('Failed to delete item');
    }
  }

  Future<String?> getUsername() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      return user.username;
    } else {
      throw Exception('No user logged in');
    }
  }
}
