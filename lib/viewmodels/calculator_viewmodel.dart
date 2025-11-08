import 'package:flutter/material.dart';
import '../models/calculator_model.dart';

class CalculatorViewModel extends ChangeNotifier {
  final CalculatorModel _model = CalculatorModel();

  String get display => _model.display;

  void onButtonPressed(String value) {
    if ('0123456789.'.contains(value)) {
      if (_model.display == '0') _model.display = '';
      _model.display += value;
    } else if (value == 'AC') {
      _model.display = '0';
      _model.firstNumber = null;
      _model.secondNumber = null;
      _model.operation = '';
    } else if (value == '+/-') {
      if (_model.display.startsWith('-')) {
        _model.display = _model.display.substring(1);
      } else {
        _model.display = '-' + _model.display;
      }
    } else if (value == '%') {
      double current = double.tryParse(_model.display) ?? 0;
      _model.display = (current / 100).toString();
    } else if (value == '=' && _model.operation.isNotEmpty) {
      _model.secondNumber = double.tryParse(_model.display);
      if (_model.firstNumber != null && _model.secondNumber != null) {
        switch (_model.operation) {
          case '+':
            _model.display = (_model.firstNumber! + _model.secondNumber!).toString();
            break;
          case '-':
            _model.display = (_model.firstNumber! - _model.secondNumber!).toString();
            break;
          case '×':
            _model.display = (_model.firstNumber! * _model.secondNumber!).toString();
            break;
          case '÷':
            _model.display = _model.secondNumber == 0
                ? 'Ошибка'
                : (_model.firstNumber! / _model.secondNumber!).toString();
            break;
        }
      }
      _model.operation = '';
      _model.firstNumber = null;
      _model.secondNumber = null;
    } else {
      _model.firstNumber = double.tryParse(_model.display);
      _model.operation = value;
      _model.display = '0';
    }
    notifyListeners();
  }
}
