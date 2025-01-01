import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_model.dart';

class CartService {
  final String baseUrl;

  CartService(this.baseUrl);

  Future<void> addToCart(CartModel cartItem) async {
    final url = '$baseUrl/cart';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(cartItem.toJSON()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Item added successfully: ${response.body}');
    } else {
      throw Exception('Failed to add item to cart: ${response.statusCode} - ${response.body}');
    }
  }
  Future<List<CartModel>> fetchCartItems() async {
    final url = '$baseUrl/cart';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => CartModel.fromJSON(item)).toList();
    } else {
      throw Exception('Failed to fetch cart items: ${response.body}');
    }
  }
}
