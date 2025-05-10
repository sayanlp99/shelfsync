import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelfsync/inventory/inventory_form_page.dart';
import 'inventory_controller.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => InventoryController()..fetchItems(),
        child: Scaffold(
          body: Consumer<InventoryController>(
            builder: (context, controller, _) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return ListTile(
                    title: Text(item.productName),
                    subtitle: Text(
                      '${item.category} - ${item.units} pcs',
                      style: const TextStyle(color: Colors.grey),
                    ), // Use grey for less emphasis
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                          ), // Use outlined edit icon
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => InventoryFormPage(item: item),
                              ),
                            );
                            if (result == true) {
                              controller.fetchItems();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outlined,
                            color: Colors.redAccent,
                          ), // Use outlined delete icon with color
                          onPressed: () {
                            controller.deleteItem(item.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final controller = context.read<InventoryController>();
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InventoryFormPage()),
              );
              if (result == true) {
                controller.fetchItems();
              }
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
