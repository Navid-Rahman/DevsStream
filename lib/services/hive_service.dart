import 'package:hive_flutter/hive_flutter.dart';

import '/model/product_hive_model.dart';

class HiveService {
  static const String productsBoxName = 'products';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductHiveModelAdapter());
    await Hive.openBox<ProductHiveModel>(productsBoxName);
  }

  // Get the box for products
  static Box<ProductHiveModel> getProductsBox() {
    return Hive.box<ProductHiveModel>(productsBoxName);
  }

  // Save products to local storage
  static Future<void> saveProducts(List<ProductHiveModel> products) async {
    final box = getProductsBox();
    await box.clear();
    await box.addAll(products);
  }

  // Get products from local storage
  static List<ProductHiveModel> getProducts() {
    final box = getProductsBox();
    return box.values.toList();
  }
}
