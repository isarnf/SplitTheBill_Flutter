import 'package:flutter/material.dart';
import 'package:split_the_bill/screens/home.dart';
import 'package:split_the_bill/screens/split.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
