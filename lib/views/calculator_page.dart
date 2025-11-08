import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/calculator_viewmodel.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  Widget buildButton(BuildContext context, String text,
      {Color? color, Color textColor = Colors.white, double flex = 1}) {
    final viewModel = Provider.of<CalculatorViewModel>(context, listen: false);
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
          onPressed: () => viewModel.onButtonPressed(text),
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
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerRight,
                child: Consumer<CalculatorViewModel>(
                  builder: (_, viewModel, __) => Text(
                    viewModel.display,
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      buildButton(context, 'AC', color: Colors.grey),
                      buildButton(context, '+/-', color: Colors.grey),
                      buildButton(context, '%', color: Colors.grey),
                      buildButton(context, '÷', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton(context, '7'),
                      buildButton(context, '8'),
                      buildButton(context, '9'),
                      buildButton(context, '×', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton(context, '4'),
                      buildButton(context, '5'),
                      buildButton(context, '6'),
                      buildButton(context, '-', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton(context, '1'),
                      buildButton(context, '2'),
                      buildButton(context, '3'),
                      buildButton(context, '+', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton(context, '0', flex: 2),
                      buildButton(context, '.'),
                      buildButton(context, '=', color: Colors.orange),
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
