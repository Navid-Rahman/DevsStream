import 'package:hive/hive.dart';

import 'product_response.dart';

part 'product_hive_model.g.dart';

@HiveType(typeId: 0)
class ProductHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final double ratingRate;

  @HiveField(7)
  final int ratingCount;

  ProductHiveModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.ratingRate,
    required this.ratingCount,
  });

  factory ProductHiveModel.fromProductResponse(ProductResponse product) {
    return ProductHiveModel(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      ratingRate: product.rating.rate,
      ratingCount: product.rating.count,
    );
  }

  ProductResponse toProductResponse() {
    return ProductResponse(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: Rating(rate: ratingRate, count: ratingCount),
    );
  }
}
