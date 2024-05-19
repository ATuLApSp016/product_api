class ProductsModel {
  int? id;
  String? title;
  String? description;
  int? price;
  num? discountPercentage;
  num? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<dynamic>? images;

  ProductsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: json['images'],
    );
  }
}
