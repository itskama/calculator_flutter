import 'package:flutter/material.dart';

void main() => runApp(MyCalculatorApp());

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  String operation = '';
  double? firstNumber;
  double? secondNumber;

  void onButtonPressed(String value) {
    setState(() {
      if ('0123456789.'.contains(value)) {
        if (display == '0') display = '';
        display += value;
      } else if (value == 'AC') {
        display = '0';
        firstNumber = null;
        secondNumber = null;
        operation = '';
      } else if (value == '+/-') {
        if (display.startsWith('-')) {
          display = display.substring(1);
        } else {
          display = '-' + display;
        }
      } else if (value == '%') {
        double current = double.tryParse(display) ?? 0;
        display = (current / 100).toString();
      } else if (value == '=' && operation.isNotEmpty) {
        secondNumber = double.tryParse(display);
        if (firstNumber != null && secondNumber != null) {
          switch (operation) {
            case '+':
              display = (firstNumber! + secondNumber!).toString();
              break;
            case '-':
              display = (firstNumber! - secondNumber!).toString();
              break;
            case '×':
              display = (firstNumber! * secondNumber!).toString();
              break;
            case '÷':
              display = secondNumber == 0
                  ? 'Ошибка'
                  : (firstNumber! / secondNumber!).toString();
              break;
          }
        }
        operation = '';
        firstNumber = null;
        secondNumber = null;
      } else {
        firstNumber = double.tryParse(display);
        operation = value;
        display = '0';
      }
    });
  }

  Widget buildButton(String text,
      {Color? color, Color textColor = Colors.white, double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Color(0xFF333333),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.all(22),
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 28, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            ),
            fit: BoxFit.cover, // растянуть на весь экран
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerRight,
                child: Text(
                  display,
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      buildButton('AC', color: Colors.grey),
                      buildButton('+/-', color: Colors.grey),
                      buildButton('%', color: Colors.grey),
                      buildButton('÷', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('×', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('-', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('+', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('0', flex: 2),
                      buildButton('.'),
                      buildButton('=', color: Colors.orange),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
