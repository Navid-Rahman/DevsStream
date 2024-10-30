import 'dart:convert';

import 'package:devsstream/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.products));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
