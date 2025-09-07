import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PageTemplate(title: "Cart");
  }
}

class _PageTemplate extends StatelessWidget {
  final String title;
  const _PageTemplate({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text("In Development", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
