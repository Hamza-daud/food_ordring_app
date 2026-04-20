class CartModel {
  final String id;
  final String name;
  final int price;
  final String image;
  int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      quantity: map['quantity'] ?? 1,
    );
  }
}
