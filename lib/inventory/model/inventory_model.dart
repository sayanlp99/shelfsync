class InventoryItem {
  final String id;
  final String productName;
  final String category;
  final double price;
  final int units;
  final DateTime dateTime;
  final String uploader;

  InventoryItem({
    required this.id,
    required this.productName,
    required this.category,
    required this.price,
    required this.units,
    required this.dateTime,
    required this.uploader,
  });

  factory InventoryItem.fromParse(Map<String, dynamic> data) {
    return InventoryItem(
      id: data['objectId'] ?? '',
      productName: data['productName'],
      category: data['category'],
      price: (data['price'] ?? 0).toDouble(),
      units: data['units'] ?? 0,
      dateTime: DateTime.parse(data['dateTime']),
      uploader: data['uploader'] ?? '',
    );
  }

  Map<String, dynamic> toParse() => {
    'productName': productName,
    'category': category,
    'price': price,
    'units': units,
    'dateTime': dateTime.toIso8601String(),
    'uploader': uploader,
  };
}
