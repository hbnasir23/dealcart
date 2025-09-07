import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String _selectedCategory = "all";

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  void filterByCategory(String category) {
    _selectedCategory = category;
    if (category == "all") {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((product) =>
      product.category?.toLowerCase() == category.toLowerCase()).toList();
    }
    notifyListeners();
  }

  Future<void> getProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      _filteredProducts = _products;
    } catch (e) {
      _products = [];
      _filteredProducts = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProductsByCategory(String category) async {
    _selectedCategory = category;
    _isLoading = true;
    notifyListeners();

    try {
      if (category == "all") {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products.where((product) =>
        product.category?.toLowerCase() == category.toLowerCase()).toList();

        if (_filteredProducts.isEmpty) {
          final categoryProducts = await _apiService.fetchProductsByCategory(category);
          _filteredProducts = categoryProducts;
        }
      }
    } catch (e) {
      _filteredProducts = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  List<String> getCategories() {
    final categories = _products.map((product) => product.category ?? '').toSet().toList();
    categories.removeWhere((category) => category.isEmpty);
    categories.sort();
    return categories;
  }
}