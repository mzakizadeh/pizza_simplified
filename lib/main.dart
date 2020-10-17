import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_simplified/ui/views/views.dart';
import 'package:pizza_simplified/ui/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Simplified',
      theme: ThemeData(
        primaryColor: accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
