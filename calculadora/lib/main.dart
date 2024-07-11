import 'package:calculadora/converter.dart';
import 'package:calculadora/investimento.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatefulWidget {
  const CalculadoraApp({super.key});

  @override
  CalculadoraAppState createState() => CalculadoraAppState();
}

class CalculadoraAppState extends State<CalculadoraApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculadoraProvedor(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CalculadoraTela(),
      ),
    );
  }
}

class CalculadoraProvedor with ChangeNotifier {
  String _input = '';
  String _output = '0';

  String get input => _input;
  String get output => _output;

  void inputNumber(String number) {
    _input += number;
    notifyListeners();
  }

  void inputOperator(String operator) {
    _input += operator;
    notifyListeners();
  }

  void inputPercentage() {
    if (_input.isNotEmpty) {
      double value = double.parse(_input) / 100;
      _input = value.toString();
      notifyListeners();
    }
  }

  void clear() {
    _input = '';
    _output = '0';
    notifyListeners();
  }

  void delete() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
      notifyListeners();
    }
  }

  void calculate() {
    try {
      Parser parser = Parser();
      Expression exp =
          parser.parse(_input.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _output = eval.toString();
      _input = '';
    } catch (e) {
      _output = 'Error';
    }
    notifyListeners();
  }
}

class CalculadoraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calculadoraProvedor = Provider.of<CalculadoraProvedor>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0, // Oculta a barra de ferramentas
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BotaoSuperior(
                  label: 'Calculadora',
                  cor: Color(0xFF0060E5),
                  rota: 'Calculadora'),
              BotaoSuperior(
                  label: 'Converter',
                  cor: Color(0xFF2D3440),
                  rota: 'Converter'),
              BotaoSuperior(
                  label: 'Investimento',
                  cor: Color(0xFF2D3440),
                  rota: 'Investimento'),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    height:
                        160), // Adiciona um espaço entre a parte superior e os botões
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        calculadoraProvedor.output,
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        calculadoraProvedor.input,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Spacer(), // Empurra os botões inferiores para a parte inferior da tela
                Row(
                  children: [
                    BotaoCalculadora(
                        label: 'C', onTap: calculadoraProvedor.clear),
                    BotaoCalculadora(
                        label: '⌫', onTap: calculadoraProvedor.delete),
                    BotaoCalculadora(
                        label: '%', onTap: calculadoraProvedor.inputPercentage),
                    BotaoCalculadora(
                        label: '÷',
                        onTap: () => calculadoraProvedor.inputOperator('/')),
                  ],
                ),
                Row(
                  children: [
                    BotaoCalculadora(
                        label: '7',
                        onTap: () => calculadoraProvedor.inputNumber('7')),
                    BotaoCalculadora(
                        label: '8',
                        onTap: () => calculadoraProvedor.inputNumber('8')),
                    BotaoCalculadora(
                        label: '9',
                        onTap: () => calculadoraProvedor.inputNumber('9')),
                    BotaoCalculadora(
                        label: '×',
                        onTap: () => calculadoraProvedor.inputOperator('*')),
                  ],
                ),
                Row(
                  children: [
                    BotaoCalculadora(
                        label: '4',
                        onTap: () => calculadoraProvedor.inputNumber('4')),
                    BotaoCalculadora(
                        label: '5',
                        onTap: () => calculadoraProvedor.inputNumber('5')),
                    BotaoCalculadora(
                        label: '6',
                        onTap: () => calculadoraProvedor.inputNumber('6')),
                    BotaoCalculadora(
                        label: '-',
                        onTap: () => calculadoraProvedor.inputOperator('-')),
                  ],
                ),
                Row(
                  children: [
                    BotaoCalculadora(
                        label: '1',
                        onTap: () => calculadoraProvedor.inputNumber('1')),
                    BotaoCalculadora(
                        label: '2',
                        onTap: () => calculadoraProvedor.inputNumber('2')),
                    BotaoCalculadora(
                        label: '3',
                        onTap: () => calculadoraProvedor.inputNumber('3')),
                    BotaoCalculadora(
                        label: '+',
                        onTap: () => calculadoraProvedor.inputOperator('+')),
                  ],
                ),
                Row(
                  children: [
                    BotaoCalculadora(
                        label: '0',
                        onTap: () => calculadoraProvedor.inputNumber('0')),
                    BotaoCalculadora(
                        label: '.',
                        onTap: () => calculadoraProvedor.inputNumber('.')),
                    BotaoCalculadora(
                        label: '=', onTap: calculadoraProvedor.calculate),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BotaoCalculadora extends StatelessWidget {
  final String label;
  final Function onTap;

  BotaoCalculadora({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: label == 'C' || label == '⌫' || label == '%'
                ? Color(0xFF363E4D)
                : label == '='
                    ? Color(0xFFE0E6EF)
                    : label == '0' ||
                            label == '.' ||
                            label == '1' ||
                            label == '2' ||
                            label == '3' ||
                            label == '4' ||
                            label == '5' ||
                            label == '6' ||
                            label == '7' ||
                            label == '8' ||
                            label == '9'
                        ? Color(0xFF242933)
                        : Color.fromRGBO(0, 96, 229, 1),
            borderRadius: label == '='
                ? BorderRadius.circular(200)
                : BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 24,
                  color: label == '=' ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class BotaoSuperior extends StatelessWidget {
  final String label;
  final double largura;
  final double altura;
  final Color cor;
  final String rota;

  BotaoSuperior(
      {required this.label,
      required this.cor,
      this.rota = '',
      this.largura = 120,
      this.altura = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: largura,
      height: altura,
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          if (rota == "Converter") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalculadoraConverter()));
          } else if (rota == "Investimento") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalculadoraInvestimento()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CalculadoraApp()));
          }
        },
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
