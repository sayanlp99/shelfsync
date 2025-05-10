import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OrderController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Order History'), elevation: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.orders.isEmpty
                ? const Center(child: Text('No orders found.'))
                : ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (_, index) {
                    final PosOrder order = controller.orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(side: BorderSide.none),
                        title: Text(
                          order.customerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order # ${order.customerNumber}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Total: ₹${order.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              DateFormat(
                                'dd/MM/yyyy HH:mm',
                              ).format(order.dateTime),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        children:
                            order.items.map((item) {
                              return ListTile(
                                title: Text(item.productName),
                                subtitle: Text(
                                  'Qty: ${item.units}, Price: ₹${item.price.toStringAsFixed(2)}',
                                ),
                                leading: const Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
