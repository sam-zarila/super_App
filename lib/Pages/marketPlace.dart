import 'package:flutter/material.dart';
import 'package:super_app/models/marketplace.model.dart';
import 'package:super_app/services/marketplace.service.dart';
 import '../Pages/Home/view_detailsPage.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final MarketplaceService marketplaceService = MarketplaceService();
  late Future<List<MarketPlaceModel>> itemsFuture;

  @override
  void initState() {
    super.initState();
    itemsFuture = marketplaceService.fetchMarketItems();
  }

  // Function to show options for the item when clicked
  void _showOptions(BuildContext context, MarketPlaceModel item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Add to Cart"),
              onTap: () {
                // Handle add to cart functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.details),
              title: Text("View Details"),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(itemId: item.id),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Market Place",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle filter functionality
            },
            icon: const Icon(Icons.filter_list, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: FutureBuilder<List<MarketPlaceModel>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load items"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No items available"));
          } else {
            final items = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            item.image,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "MWK ${item.price}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => _showOptions(context, item),
                                child: const Icon(
                                  Icons.add_circle,
                                  color: Colors.redAccent,
                                ),
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
        },
      ),
    );
  }
}
