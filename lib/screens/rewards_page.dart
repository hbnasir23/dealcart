import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PageTemplate(title: "Rewards");
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
