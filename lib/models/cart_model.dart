class CartModel {
  final String userId;
  final int item;
  final int quantity;
  final String image;
  final String name;
  final double price;
  final String description;
  final String comment;

  CartModel({
    required this.userId,
    required this.item,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.comment,
  });

  // ✅ Rename to `toJson` (Standard Dart convention)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'item': item,
      'quantity': quantity,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'comment': comment,
    };
  }

  // ✅ Rename to `fromJson` (Matches Dart convention)
  static CartModel fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['userId'],
      item: json['item'],
      quantity: json['quantity'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(), // Ensure it's a double
      description: json['description'],
      comment: json['comment'],
    );
  }
}
