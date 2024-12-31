import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Latest_model.dart';

class LatestArrivalServices {
  final String _baseUrl = 'http://127.0.0.1:3000/latestarrivalservices';

  Future<List<LatestArrivalModels>> fetchLatestArrivals() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) =>
                LatestArrivalModels.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('failed to fetch latest arrivals ');
      }
    } catch (e) {
      throw Exception('Error fetching latest items: $e');
    }
  }
}
