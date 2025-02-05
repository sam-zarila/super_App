import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_model.dart';

class CartService {
  final String baseUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance; // ✅ Fixed

  CartService(this.baseUrl);

  // ✅ Get Firebase user ID
  Future<String?> _getUserId() async {
    final user = _auth.currentUser;
    return user?.uid;
  }

  // ✅ Get Firebase auth token
  Future<String?> _getToken() async {
    final user = _auth.currentUser;
    
    return user != null ? await user.getIdToken() : null;
  }

  // ✅ Add item to cart
  Future<void> addToCart(CartModel cartItem) async {
    final token = await _getToken();
    if (token == null) throw Exception('User not logged in');

    final url = Uri.parse('$baseUrl/cart');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token', // ✅ Send token for authentication
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'item': cartItem.item,
        'quantity': cartItem.quantity,
        'image': cartItem.image,
        'name': cartItem.name,
        'price': cartItem.price,
        'description': cartItem.description,
        'comment': cartItem.comment,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('auth token:'+token);
      throw Exception('Failed to add item to cart: ${response.body}');
    }
  }
  

  // ✅ Fetch cart items
  Future<List<CartModel>> fetchCartItems() async {
    final token = await _getToken();
    if (token == null) throw Exception("User not logged in");
    print(token);

    final url = Uri.parse(
        '$baseUrl/cart'); // ✅ No need to send UID, extracted from token

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // ✅ Backend extracts UID from token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CartModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch cart items: ${response.body}');
    }
  }

  // ✅ Remove item from cart
  Future<void> removeFromCart(int itemId) async {
    final token = await _getToken();
    if (token == null) throw Exception('User not logged in');
    

    final url = Uri.parse('$baseUrl/cart/$itemId'); // ✅ Corrected URL

    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove item: ${response.body}');
    }
  }
}
