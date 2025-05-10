import 'package:flutter/material.dart';
import '../model/inventory_model.dart';
import '../service/inventory_service.dart';

class InventoryController extends ChangeNotifier {
  final InventoryService _service = InventoryService();

  List<InventoryItem> items = [];
  bool isLoading = false;

  Future<void> fetchItems() async {
    isLoading = true;
    notifyListeners();
    try {
      items = await _service.getItems();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(InventoryItem item) async {
    await _service.addItem(item);
    await fetchItems();
  }

  Future<void> updateItem(InventoryItem item) async {
    await _service.updateItem(item);
    await fetchItems();
  }

  Future<void> deleteItem(String id) async {
    await _service.deleteItem(id);
    await fetchItems();
  }

  Future<String?> getUsername() async {
    return await _service.getUsername();
  }
}
