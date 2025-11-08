import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/calculator_viewmodel.dart';
import 'views/calculator_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CalculatorViewModel(),
      child: MyCalculatorApp(),
    ),
  );
}

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}
