import 'package:flutter/material.dart';
import 'package:shelfsync/pos/pos_model.dart';
import 'package:shelfsync/pos/pos_service.dart';

class OrderController extends ChangeNotifier {
  final PosService _service = PosService();

  List<PosOrder> orders = [];
  bool isLoading = false;

  Future<void> fetchOrders() async {
    isLoading = true;
    notifyListeners();
    try {
      orders = await _service.getAllOrders();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
