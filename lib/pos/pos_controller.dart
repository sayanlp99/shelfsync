import 'package:flutter/material.dart';
import 'package:shelfsync/inventory/inventory_model.dart';
import 'package:shelfsync/inventory/inventory_service.dart';
import 'package:shelfsync/pos/pos_model.dart';
import 'package:shelfsync/pos/pos_service.dart';

class PosController extends ChangeNotifier {
  final InventoryService _inventoryService = InventoryService();
  final PosService _posService = PosService();

  List<InventoryItem> allItems = [];
  List<InventoryItem> searchResults = [];
  List<PosCartItem> cartItems = [];

  String customerName = '';
  String customerNumber = '';
  bool isLoading = false;

  Future<void> loadInventory() async {
    isLoading = true;
    notifyListeners();
    try {
      allItems = await _inventoryService.getItems();
      searchResults = allItems;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateSearch(String query) {
    searchResults =
        allItems
            .where(
              (item) =>
                  item.productName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
  }

  void addToCart(InventoryItem item) {
    final existing = cartItems.where((e) => e.item.id == item.id).toList();
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      cartItems.add(PosCartItem(item: item));
    }
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    cartItems.removeWhere((e) => e.item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final item = cartItems.firstWhere((e) => e.item.id == itemId);
    item.quantity = quantity;
    notifyListeners();
  }

  double get totalAmount {
    return cartItems.fold(
      0.0,
      (sum, i) => sum + (i.item.price * i.quantity.toDouble()),
    );
  }

  Future<void> checkout() async {
    if (customerName.isEmpty || customerNumber.isEmpty || cartItems.isEmpty) {
      throw Exception("Fill customer info and add items");
    }

    final order = PosOrder(
      id: '',
      customerName: customerName,
      customerNumber: customerNumber,
      items:
          cartItems.map((e) {
            return InventoryItem(
              id: e.item.id,
              productName: e.item.productName,
              category: e.item.category,
              price: e.item.price,
              units: e.quantity,
              dateTime: e.item.dateTime,
              uploader: e.item.uploader,
            );
          }).toList(),
      totalAmount: totalAmount,
      dateTime: DateTime.now(),
    );

    await _posService.createOrder(order);
    cartItems.clear();
    customerName = '';
    customerNumber = '';
    notifyListeners();
  }
}
