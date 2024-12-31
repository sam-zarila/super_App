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
    _itemDetails = MarketplaceService().getItemDetails(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Image
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 16),
                // Right side: Name, Price, and Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item Name
                      Text(
                        item.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      // Item Price
                      Text(
                        'Price: MWK ${item.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      SizedBox(height: 16),
                      // Item Description
                      Text(
                        'Description of the item goes here. This can be a detailed explanation about the product, including its features, specifications, and other relevant details.',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      // Button to add item to cart
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for adding to cart
                        },
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
