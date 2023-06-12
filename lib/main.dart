import 'package:flutter/material.dart';
import 'package:flutter_recipe/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Recipe App',
      theme: ThemeData(
        primaryColor: Colors.orange[300],
      ),
      home: SearchScreen(),
    );
  }
}
