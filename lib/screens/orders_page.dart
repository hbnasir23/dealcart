import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PageTemplate(title: "Orders");
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
