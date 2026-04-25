import 'package:flutter/material.dart';

void main() {
  runApp(const HumanGachaApp());
}

class HumanGachaApp extends StatelessWidget {
  const HumanGachaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Human Gacha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const Scaffold(body: Center(child: Text('Human Gacha'))),
    );
  }
}
