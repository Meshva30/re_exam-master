class ShoppingItem {
  String id;
  String name;
  int quantity;
  double price;

  ShoppingItem({required this.id, required this.name, required this.quantity, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0.0,
    );
  }
}
