import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelfsync/pos/order_controller.dart';
import 'package:shelfsync/pos/pos_model.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderController>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OrderController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body:
          controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.orders.isEmpty
              ? const Center(child: Text('No orders found.'))
              : ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (_, index) {
                  final PosOrder order = controller.orders[index];
                  return ExpansionTile(
                    title: Text(
                      '${order.customerName} (${order.customerNumber})',
                    ),
                    subtitle: Text(
                      'Total: ₹${order.totalAmount.toStringAsFixed(2)}\n${order.dateTime.toLocal()}',
                    ),
                    children:
                        order.items.map((item) {
                          return ListTile(
                            title: Text(item.productName),
                            subtitle: Text(
                              'Qty: ${item.units}, ₹${item.price.toStringAsFixed(2)}',
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
    );
  }
}
