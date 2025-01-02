import 'package:flutter/material.dart';
import 'package:super_app/models/cart_model.dart';
import 'package:super_app/models/marketplace.model.dart';
import 'package:super_app/models/view_details.dart';
import 'package:super_app/services/cart_services.dart';
import '../../services/view_details.service.dart';

class DetailsPage extends StatefulWidget {
  final int itemId;
  final CartService cartService;

  DetailsPage({required this.itemId, required this.cartService});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<MarketplaceDetailModel?> _itemDetails;

  @override
  void initState() {
    super.initState();
    _itemDetails = MarketplaceService().getItemDetails(widget.itemId);
  }

  Future<void> _addToCart(MarketplaceDetailModel item) async {
    final cartItem = CartModel(
      item: item.id,
      quantity: 1,
      name: item.name,
      image: item.image,
      price: item.price,
      description: item.description,
    );

    try {
      await widget.cartService.addToCart(cartItem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.name} added to cart successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add ${item.name} to cart: $e')),
      );
    }
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
                  // Product Image
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
                  SizedBox(height: 16),

                  // Product Details
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MWK ${item.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      Text(
                        'Available in stock',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Size Selector
                  Text(
                    'Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [39, 40, 41, 42].map((size) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(size.toString()),
                          selected: false,
                          onSelected: (selected) {
                            // Handle size selection
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),

                  // Description
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Add to Cart Button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

                      // Buy Now Button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Buy functionality
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
