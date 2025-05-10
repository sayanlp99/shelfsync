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
    final List itemsData = data['items'] ?? [];
    return PosOrder(
      id: data['objectId'],
      customerName: data['customerName'],
      customerNumber: data['customerNumber'],
      items: itemsData.map((e) => InventoryItem.fromParse(e)).toList(),
      totalAmount: (data['totalAmount'] ?? 0).toDouble(),
      dateTime: DateTime.parse(data['dateTime']),
    );
  }
}
