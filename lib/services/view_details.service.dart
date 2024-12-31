import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/view_details.dart';

class MarketplaceService {
  // Replace with your API endpoint
  final String baseUrl = 'http://127.0.0.1:3000/marketplace';

  // Function to fetch details of a specific marketplace item by ID
  Future<MarketplaceDetailModel?> getItemDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return MarketplaceDetailModel.fromJson(json.decode(response.body));
    } else {
      // If the server returns an error, throw an exception
      throw Exception('Failed to load item details');
    }
  }
}
