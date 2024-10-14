

class ShoppingItem {
  int? id;
  String name;
  int quantity;
  String category;
  bool purchased;

  ShoppingItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.category,
    this.purchased = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category,
      'purchased': purchased ? 1 : 0,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      category: map['category'],
      purchased: map['purchased'] == 1,
    );
  }
}
