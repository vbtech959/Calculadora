import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Apagar';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == 'Apagar') {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _expressao.split('=').last;
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Não foi possível calcular.';
    }
  }

  double _avaliarExpressao(String expressao) {
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor) {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2440555351.
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Text(
          _expressao,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
      Expanded(
        child: Text(
          _resultado,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
      Expanded(
          flex: 3,
          child:
              GridView.count(crossAxisCount: 4, childAspectRatio: 2, children: [
            _botao('7'),
            _botao('8'),
            _botao('9'),
            _botao('/'),
            _botao('4'),
            _botao('5'),
            _botao('6'),
            _botao('*'),
            _botao('1'),
            _botao('2'),
            _botao('3'),
            _botao('-'),
            _botao('0'),
            _botao('.'),
            _botao('+'),
            _botao('='),
          ])),
      Expanded(
        child: _botao(_limpar),
      )
    ]);
  }
}
