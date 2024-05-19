import 'package:products_api/models/products_model.dart';

class ProductDataModel {
  List<ProductsModel>? products;
  int? total;
  int? skip;
  int? limit;

  ProductDataModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    List<ProductsModel> mProducts = [];

    for (Map<String, dynamic> eachProducts in json['products']) {
      mProducts.add(ProductsModel.fromJson(eachProducts));
    }
    return ProductDataModel(
      products: mProducts,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
