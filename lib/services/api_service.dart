import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get("https://dummyjson.com/products");
      final List products = response.data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await _dio.get("https://dummyjson.com/products/category/$category");
      final List products = response.data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products by category: $e");
    }
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response = await _dio.get("https://dummyjson.com/products/categories");
      return List<String>.from(response.data);
    } catch (e) {
      throw Exception("Failed to load categories: $e");
    }
  }
}