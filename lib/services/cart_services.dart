import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_model.dart';

class CartService {
  final String baseUrl;

  CartService(this.baseUrl);

  Future<void> addToCart(CartModel cartItem) async {
    final url = '$baseUrl/cart';

    final response = await http.post(Uri.parse(url),
     headers: {
      'Content-Type': 'application/json',
     },
     body: json.encode(cartItem.toJSON()),
    
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      
    } else {
      
    }
  }
}
