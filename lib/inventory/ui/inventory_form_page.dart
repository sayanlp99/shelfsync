import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shelfsync/inventory/controller/inventory_controller.dart';
import 'package:shelfsync/inventory/model/inventory_model.dart';

class InventoryFormPage extends StatefulWidget {
  final InventoryItem? item;

  const InventoryFormPage({super.key, this.item});

  @override
  State<InventoryFormPage> createState() => _InventoryFormPageState();
}

class _InventoryFormPageState extends State<InventoryFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _unitsController;

  DateTime _selectedDate = DateTime.now();
  final bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.item?.productName ?? '',
    );
    _categoryController = TextEditingController(
      text: widget.item?.category ?? '',
    );
    _priceController = TextEditingController(
      text: widget.item != null ? widget.item!.price.toString() : '',
    );
    _unitsController = TextEditingController(
      text: widget.item != null ? widget.item!.units.toString() : '',
    );
    _selectedDate = widget.item?.dateTime ?? DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _unitsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!mounted) return;
    final controller = context.read<InventoryController>();

    final product = InventoryItem(
      id: widget.item?.id ?? '',
      productName: _nameController.text,
      category: _categoryController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      units: int.tryParse(_unitsController.text) ?? 0,
      dateTime: _selectedDate,
      uploader: await controller.getUsername() ?? '',
    );

    if (widget.item == null) {
      await controller.addItem(product);
    } else {
      await controller.updateItem(product);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Inventory' : 'Add Inventory'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body:
          _isSaving
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Product Name is required'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _categoryController,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Category is required'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Price is required'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _unitsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Units',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'Units are required'
                                    : null,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date: ${DateFormat.yMMMd().format(_selectedDate)}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today_outlined),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: Icon(
                          isEdit ? Icons.save_outlined : Icons.add_outlined,
                        ),
                        label: Text(
                          isEdit ? 'Update Item' : 'Add Item',
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
