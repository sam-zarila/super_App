import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/marketplace.model.dart';

class MarketplaceService {
  final String _baseUrl = 'http://127.0.0.1:3000/marketplace';

  Future<List<MarketPlaceModel>> fetchMarketItems() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MarketPlaceModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to fetch market items');
      }
    } catch (e) {
      throw Exception('Error fetching market items: $e');
    }
  }
}
