import 'package:flutter/material.dart';
import '../constants/categories.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final List<AnimationController> controllers;
  late final List<Animation<double>> slideAnimations;

  final List<Map<String, dynamic>> _splashProducts = [
    {
      "category": "smartphones",
      "asset": "assets/splash/smartphone.png",
    },
    {
      "category": "laptops",
      "asset": "assets/splash/laptop.png",
    },
    {
      "category": "fragrances",
      "asset": "assets/splash/perfume.png",
    },
    {
      "category": "skincare",
      "asset": "assets/splash/skincare.png",
    },
    {
      "category": "groceries",
      "asset": "assets/splash/groceries.png",
    },
    {
      "category": "home-decoration",
      "asset": "assets/splash/home_decor.png",
    },
    {
      "category": "furniture",
      "asset": "assets/splash/furniture.png",
    },
    {
      "category": "womens-dresses",
      "asset": "assets/splash/dress.png",
    },
    {
      "category": "mens-shirts",
      "asset": "assets/splash/shirt.png",
    },
    {
      "category": "womens-bags",
      "asset": "assets/splash/bag.png",
    },
    {
      "category": "sunglasses",
      "asset": "assets/splash/sunglasses.png",
    },
    {
      "category": "automotive",
      "asset": "assets/splash/car_accessory.png",
    },
  ];

  @override
  void initState() {
    super.initState();

    controllers = List.generate(
      4,
          (i) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 3000 + i * 500),
      ),
    );

    slideAnimations = controllers
        .map((c) => Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(
        parent: c,
        curve: Curves.easeInOut,
      ),
    ))
        .toList();

    for (int i = 0; i < controllers.length; i++) {
      controllers[i].repeat(reverse: true);
    }

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

    Color _getCategoryColor(String category) {
    return AppCategories.getCategoryColor(category).withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topHeight = size.height * 0.75;
    final bottomHeight = size.height * 0.25;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [

              Opacity(
                opacity: 0.6,
                child: SizedBox(
                  height: topHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (i) {
                        return Expanded(
                          child: AnimatedBuilder(
                            animation: slideAnimations[i],
                            builder: (context, child) {
                              double dx = slideAnimations[i].value * (size.width * 0.08);
                              if (i % 2 == 1) dx = -dx;
                              return Transform.translate(
                                offset: Offset(dx, 0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(3, (j) {
                                    final productIndex = i * 3 + j;
                                    if (productIndex >= _splashProducts.length) {
                                      return const SizedBox.shrink();
                                    }
                                    final product = _splashProducts[productIndex];
                                    return Container(
                                      width: size.width * 0.35,
                                      height: size.width * 0.35,
                                      margin: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: _getCategoryColor(product["category"]),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          product["asset"],
                                          width: size.width * 0.25,
                                          height: size.width * 0.25,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {

                                            return Icon(
                                              Icons.shopping_bag,
                                              size: size.width * 0.15,
                                              color: Colors.white.withOpacity(0.8),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: bottomHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      "Pakistan ki sabse sasti shopping application",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF153C9F),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Made with ❤️ in Pakistan",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            bottom: bottomHeight - 30,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag_rounded,
                size: 48,
                color: Color(0xFF153C9F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}