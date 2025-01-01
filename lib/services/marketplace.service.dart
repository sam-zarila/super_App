import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/marketplace.model.dart';

class MarketplaceService {
  final String _baseUrl = 'http://127.0.0.1:3000/marketplace';

  // Fetch list of market items
  Future<List<MarketPlaceModel>> fetchMarketItems() async {
    try {
      final uri = Uri.parse(_baseUrl);

      // Make the HTTP GET request with a timeout to handle network delays
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        
        // Map each item into MarketPlaceModel and return as a list
        return data.map((json) => MarketPlaceModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        // Log the response status for debugging
        print('Failed to fetch market items: ${response.statusCode}');
        throw Exception('Failed to fetch market items: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on http.ClientException catch (e) {
      // Handle client-side errors (e.g., network issues)
      print('Client error: $e');
      throw Exception('Error fetching market items due to client-side issue');
    } on TimeoutException {
      // Handle timeout errors
      print('Error: Request timed out');
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      // Handle all other exceptions
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred while fetching market items: $e');
    }
  }
}
