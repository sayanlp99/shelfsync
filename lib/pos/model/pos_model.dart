import 'package:shelfsync/inventory/model/inventory_model.dart';

class PosOrder {
  final String id;
  final String customerName;
  final String customerNumber;
  final List<InventoryItem> items;
  final double totalAmount;
  final DateTime dateTime;

  PosOrder({
    required this.id,
    required this.customerName,
    required this.customerNumber,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  factory PosOrder.fromParse(Map<String, dynamic> data) {
    final List rawItems = data['items'] ?? [];
    return PosOrder(
      id: data['objectId'],
      customerName: data['customerName'],
      customerNumber: data['customerNumber'],
      items: rawItems.map((e) => InventoryItem.fromParse(e)).toList(),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      dateTime: DateTime.parse(data['dateTime']),
    );
  }

  Map<String, dynamic> toParse() => {
    'customerName': customerName,
    'customerNumber': customerNumber,
    'items': items.map((e) => e.toParse()).toList(),
    'totalAmount': totalAmount,
    'dateTime': dateTime.toIso8601String(),
  };
}

class PosCartItem {
  final InventoryItem item;
  int quantity;

  PosCartItem({required this.item, this.quantity = 1});
}
