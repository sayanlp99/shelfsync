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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                labelText: "Customer Name",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
              ),
              onChanged: (val) => controller.customerName = val,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _customerNumberController,
              decoration: const InputDecoration(
                labelText: "Customer Number",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (val) => controller.customerNumber = val,
            ),
            const SizedBox(height: 12),
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
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (_, index) {
                  final PosCartItem cartItem = controller.cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.item.productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '₹${cartItem.item.price.toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                          ),
                          Row(
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
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  controller.removeFromCart(cartItem.item.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16), // Increased spacing
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
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                "Checkout ₹${controller.totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16),
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
        child: const Icon(Icons.history),
      ),
    );
  }
}
