class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final String? category;
  final double? discount;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    this.category,
    this.discount,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      category: json['category'] ?? '',
      discount: (json['discountPercentage'] != null)
          ? (json['discountPercentage'] as num).toDouble()
          : null,
    );
  }
}