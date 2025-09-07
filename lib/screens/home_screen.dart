import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../constants/categories.dart';
import 'widgets/product_card.dart';
import 'widgets/shop_category_item.dart';
import 'widgets/home_header.dart';
import 'widgets/search_bar.dart';
import 'widgets/top_categories_section.dart';
import 'widgets/banner_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _searchHints = ["Search Piyaaz", "Search Aalu", "Search Oil", "Search Rozana"];

  final ScrollController _topCategoryController = ScrollController();
  final ScrollController _shopCategoryController = ScrollController();
  double _shopCategoryScrollPosition = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProducts();

    _shopCategoryController.addListener(() {
      setState(() {
        _shopCategoryScrollPosition = _shopCategoryController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _topCategoryController.dispose();
    _shopCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final double shopCategoryMaxScroll = _shopCategoryController.hasClients
        ? _shopCategoryController.position.maxScrollExtent
        : 1;

    final selectedCategory = productProvider.selectedCategory;
    final categoryProducts = productProvider.products;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: _getTopBackgroundColor(selectedCategory),
              child: Column(
                children: [
                  const HomeHeader(),
                  AnimatedSearchBar(searchHints: _searchHints),
                  TopCategoriesSection(
                    categories: AppCategories.allCategories,
                    selectedCategory: selectedCategory,
                    selectedCategoryColor: _getTopBackgroundColor(selectedCategory),
                    onCategorySelected: (category) {
                      productProvider.filterByCategory(category);
                    },
                    scrollController: _topCategoryController,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BannerCarousel(),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Shop by Categories",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 200,
                        child: GridView(
                          controller: _shopCategoryController,
                          scrollDirection: Axis.horizontal,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.9,
                          ),
                          children: AppCategories.allCategories.map((category) =>
                              ShopCategoryItem(
                                icon: category["icon"],
                                label: category["name"],
                                color: category["color"],
                                onTap: () => productProvider.filterByCategory(category["name"]),
                              )
                          ).toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: shopCategoryMaxScroll > 0
                            ? _shopCategoryScrollPosition / shopCategoryMaxScroll
                            : 0,
                        color: Colors.deepPurple,
                        backgroundColor: Colors.grey[300],
                        minHeight: 2,
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Getting Started",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 250,
                        child: categoryProducts.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProducts.length > 6
                              ? 6
                              : categoryProducts.length,
                          itemBuilder: (context, index) {
                            final product = categoryProducts[index];
                            return Container(
                              width: 170,
                              margin: EdgeInsets.only(
                                  right: 12,
                                  left: index == 0 ? 16 : 0,
                                  bottom: 16),
                              child: ProductCard(product: product),
                            );
                          },
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("More Products",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      productProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryProducts.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (context, index) {
                          final product = categoryProducts[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTopBackgroundColor(String selectedCategory) {
    if (selectedCategory == "all") return Colors.grey[200]!;

    final category = AppCategories.findCategoryByName(selectedCategory);
    return category != null
        ? (category["color"] as Color).withOpacity(0.1)
        : Colors.grey[200]!;
  }
}