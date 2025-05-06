import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shelfsync/pos/pos_model.dart';

class PosService {
  Future<void> createOrder(PosOrder order) async {
    final parseObject =
        ParseObject('PosOrder')
          ..set('customerName', order.customerName)
          ..set('customerNumber', order.customerNumber)
          ..set('items', order.items.map((i) => i.toParse()).toList())
          ..set('totalAmount', order.totalAmount)
          ..set('dateTime', order.dateTime.toIso8601String());

    final response = await parseObject.save();
    if (!response.success) {
      throw Exception('Failed to create order: ${response.error?.message}');
    }
  }

  Future<List<PosOrder>> getAllOrders() async {
    final query = QueryBuilder(ParseObject('PosOrder'))
      ..orderByDescending('createdAt');

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!
          .map((e) => PosOrder.fromParse(e.toJson()))
          .toList();
    } else {
      return [];
    }
  }
}
