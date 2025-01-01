
class CartModel {
  final int item; 
  final int quantity; 
   final String image; 
  final String name; 
  final int price;
  final String description;

  CartModel({
    required this.item,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJSON() {
    return {
      'item': item,
      'quantity': quantity,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
    };
  }

  // Complete the fromJSON method to convert a JSON object into a CartItem
  static CartModel fromJSON(Map<String, dynamic> json) {
    return CartModel(
      item: json['item'],
      quantity: json['quantity'],
      name: json['name'],
      image: json['image'],
      price: json['price'], 
      description: json['description'],
    );
  }
}
