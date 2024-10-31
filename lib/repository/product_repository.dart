import 'dart:convert';

import 'package:http/http.dart' as http;

import '/constants/api_endpoints.dart';
import '/model/product_hive_model.dart';
import '/model/product_response.dart';
import '/services/hive_service.dart';

class ProductRepository {
  Future<List<ProductResponse>> getProducts() async {
    try {
      // First, try to get data from local storage
      final localProducts = HiveService.getProducts();
      if (localProducts.isNotEmpty) {
        return localProducts.map((e) => e.toProductResponse()).toList();
      }

      // If local storage is empty, fetch from API
      final response = await http.get(Uri.parse(ApiEndpoints.products));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final products =
            jsonData.map((json) => ProductResponse.fromJson(json)).toList();

        // Save to local storage
        await HiveService.saveProducts(
          products.map((e) => ProductHiveModel.fromProductResponse(e)).toList(),
        );

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
