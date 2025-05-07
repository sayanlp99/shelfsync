import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelfsync/pos/order_list_page.dart';
import 'package:shelfsync/pos/pos_controller.dart';
import 'package:shelfsync/pos/pos_model.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<PosController>(context, listen: false).loadInventory();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PosController>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(labelText: "Customer Name"),
              onChanged: (val) => controller.customerName = val,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _customerNumberController,
              decoration: const InputDecoration(labelText: "Customer Number"),
              keyboardType: TextInputType.phone,
              onChanged: (val) => controller.customerNumber = val,
            ),
            const SizedBox(height: 8),
            Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                controller.updateSearch(textEditingValue.text);
                return controller.searchResults;
              },
              displayStringForOption: (item) => item.productName,
              onSelected: (item) {
                controller.addToCart(item);
                _searchController.clear();
              },
              fieldViewBuilder: (
                context,
                tController,
                focusNode,
                onFieldSubmitted,
              ) {
                _searchController.value = tController.value;
                return TextField(
                  controller: tController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Search Items',
                    prefixIcon: Icon(Icons.search),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (_, index) {
                  final PosCartItem cartItem = controller.cartItems[index];
                  return ListTile(
                    title: Text(cartItem.item.productName),
                    subtitle: Text('₹${cartItem.item.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (cartItem.quantity > 1) {
                              controller.updateQuantity(
                                cartItem.item.id,
                                cartItem.quantity - 1,
                              );
                            }
                          },
                        ),
                        Text(cartItem.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            controller.updateQuantity(
                              cartItem.item.id,
                              cartItem.quantity + 1,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.removeFromCart(cartItem.item.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                try {
                  await controller.checkout();
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text("Order placed successfully"),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                }
              },
              child: Text(
                "Checkout ₹${controller.totalAmount.toStringAsFixed(2)}",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrderListPage()),
          );
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}
