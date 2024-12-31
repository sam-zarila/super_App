import 'package:flutter/material.dart';
import '../../models/view_details.dart';
import '../../services/view_details.service.dart';

class DetailsPage extends StatefulWidget {
  final int itemId;

  DetailsPage({required this.itemId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<MarketplaceDetailModel?> _itemDetails;

  @override
  void initState() {
    super.initState();
    // Fetch item details based on the passed itemId
    _itemDetails = MarketplaceService().getItemDetails(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
        backgroundColor: Colors.white,
        elevation: 2,
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

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image at the top
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),

                // Name and Price below the image
                Text(
                  item.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Price: MWK ${item.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(height: 16),

                // Description below the price
                Text(
                  item.description, // Assuming description is part of MarketplaceDetailModel
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),

                // Button to add item to cart
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for adding to cart
                    print('Item added to cart');
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
