import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_app/models/cart_model.dart';
import 'package:super_app/models/marketplace.model.dart';
import 'package:super_app/models/view_details.dart';
import 'package:super_app/services/cart_services.dart';
import '../../services/view_details.service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailsPage extends StatefulWidget {
  final int itemId;
  final CartService cartService;

  DetailsPage({required this.itemId, required this.cartService});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<MarketplaceDetailModel?> _itemDetails;
  final TextEditingController _commentController = TextEditingController();
  final FToast _fToast = FToast();

  @override
  void initState() {
    super.initState();
    _itemDetails = MarketplaceService().getItemDetails(widget.itemId);
    _fToast.init(context); // Initialize toast notifications
  }

 Future<void> _addToCart(MarketplaceDetailModel item) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    showCustomToast("Authentication error. Please log in again.", Icons.error, Colors.red);
    return;
  }

  final cartItem = CartModel(
    userId: user.uid, // Ensure the cart item is linked to the logged-in user
    item: item.id,
    quantity: 1,
    name: item.name,
    image: item.image,
    price: item.price,
    description: item.description,
    comment: _commentController.text,
  );

  try {
    await widget.cartService.addToCart(cartItem);
    showCustomToast("${item.name} added to your cart!", Icons.check_circle, Colors.green);
  } catch (e) {
    showCustomToast("Failed to add ${item.name}: $e", Icons.error, Colors.red);
  }
}
  void showCustomToast(String message, IconData icon, Color color) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12.0),
          Flexible(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );

    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              // Favorite button action
                     showCustomToast("Favorite button action feature coming soon!", Icons.info, Colors.blue);
            },
          ),
        ],
      ),
      body: FutureBuilder<MarketplaceDetailModel?>(
        future: _itemDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('Item not found'));
          }

          final item = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        item.image,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  Text(
                    item.name,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'MWK ${item.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Available in stock',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 24),

                  Text(
                    'Add a Note (Optional)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write your preferences or special instructions...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () => _addToCart(item),
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                        label: Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          showCustomToast("Buy Now feature coming soon!", Icons.info, Colors.blue);
                        },
                        icon: Icon(Icons.shopping_bag, color: Colors.white),
                        label: Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
