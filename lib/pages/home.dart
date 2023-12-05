import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
        child: Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Volte')),
      ),
    ));
  }
}
