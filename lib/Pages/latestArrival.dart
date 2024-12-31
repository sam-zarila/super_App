import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LatestArrival extends StatefulWidget {
  const LatestArrival({Key? key}) : super(key: key);

  @override
  _LatestArrivalState createState() => _LatestArrivalState();
}

class _LatestArrivalState extends State<LatestArrival> {
  Future<List<Map<String, String>>> fetchRandomProducts() async {
    try {
      // Replace with an actual product API
      final response = await http.get(
        Uri.parse(''), // Use a valid endpoint
        headers: {
          'Authorization': 'Bearer your_token', // Add necessary headers if needed
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((product) {
          return {
            'name': product['name'].toString(),
            'image': product['imageUrl'].toString(),
          };
        }).toList();
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Text(
              'Latest Arrival',
              key: const ValueKey<String>('LatestArrivalTitle'),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<Map<String, String>>>(
            future: fetchRandomProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              } else {
                final products = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Image.network(
                            products[index]['image']!,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              products[index]['name']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
