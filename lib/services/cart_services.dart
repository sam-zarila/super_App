import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final String baseUrl;

  CartService(this.baseUrl);

  // Function to retrieve the user's token from shared preferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Add item to the cart with token authentication
  Future<void> addToCart(CartModel cartItem) async {
    final url = '$baseUrl/cart'; // Ensure '/cart' is included in the URL

    final token = await _getToken(); // Get token from shared preferences
    if (token == null) {
      throw Exception('User not logged in');
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include token in headers
      },
      body: json.encode({
        'item': cartItem.item,
        'quantity': cartItem.quantity,
        'image': cartItem.image,
        'name': cartItem.name,
        'price': cartItem.price,
        'description': cartItem.description, // Ensure you're passing description if needed
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Item added successfully: ${response.body}');
    } else {
      throw Exception('Failed to add item to cart: ${response.statusCode} - ${response.body}');
    }
  }

  // Fetch cart items for the logged-in user
  Future<List<CartModel>> fetchCartItems({required String userId}) async {
    final token = await _getToken(); // Get token from shared preferences
    if (token == null) {
      throw Exception('User not logged in');
    }

    final url = '$baseUrl/cart';  // Ensure your API is fetching cart for logged-in user

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', // Include token in headers
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => CartModel.fromJSON(item)).toList();
    } else {
      throw Exception('Failed to fetch cart items: ${response.statusCode} - ${response.body}');
    }
  }
}
