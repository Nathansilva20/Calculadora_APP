import 'package:calculadora/converter.dart';
import 'package:calculadora/historico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TempoConverter());
}

class TempoConverter extends StatefulWidget {
  const TempoConverter({super.key});

  @override
  TempoConverterState createState() => TempoConverterState();
}

class TempoConverterState extends State<TempoConverter> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculadoraProvedor(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TempoConverterTela(),
      ),
    );
  }
}

class CalculadoraProvedor with ChangeNotifier {
  String _input = '';
  String _outputHour = '0';
  String _outputMinute = '0';
  String _outputSeconds = '0';

  String get input => _input;
  String get outputHour => _outputHour;
  String get outputMinute => _outputMinute;
  String get outputSeconds => _outputSeconds;

  void inputNumber(String number) {
    _input += number;
    notifyListeners();
  }

  void clear() {
    _input = '';
    _outputHour = '0';
    _outputMinute = '0';
    _outputSeconds = '0';

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
      int evalHour = int.parse(_input) * 24;
      int evalMinute = evalHour * 60;
      int evalSeconds = evalMinute * 60;
      _outputHour = evalHour.toString();
      _outputMinute = evalMinute.toString();
      _outputSeconds = evalSeconds.toString();
    } catch (e) {
      _outputHour = 'Error';
      _outputMinute = 'Error';
      _outputSeconds = 'Error';
    }
    notifyListeners();
  }
}

class TempoConverterTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calculadoraProvedor = Provider.of<CalculadoraProvedor>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BotaoSuperior(
                  label: 'Calculadora',
                  cor: const Color(0xFF2D3440),
                  rota: 'Calculadora'),
              BotaoSuperior(
                  label: 'Converter',
                  cor: const Color(0xFF0060E5),
                  rota: 'Converter'),
              BotaoSuperior(
                  label: 'Historico',
                  cor: const Color(0xFF2D3440),
                  rota: 'Historico'),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dias",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      calculadoraProvedor.input,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Horas",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      calculadoraProvedor.outputHour,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Minutos",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      calculadoraProvedor.outputMinute,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Segundos",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      calculadoraProvedor.outputSeconds,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    BotaoCalculadora(
                        label: 'C', onTap: calculadoraProvedor.clear),
                    BotaoCalculadora(
                        label: '⌫', onTap: calculadoraProvedor.delete),
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
                  ],
                ),
                Row(
                  children: [
                    BotaoCalculadora(
                        label: '0',
                        onTap: () => calculadoraProvedor.inputNumber('0')),
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
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: label == 'C' || label == '⌫' || label == '%'
                ? const Color(0xFF363E4D)
                : label == '='
                    ? const Color(0xFFE0E6EF)
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
                        ? const Color(0xFF242933)
                        : const Color.fromRGBO(0, 96, 229, 1),
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
                    builder: (context) => const CalculadoraConverter()));
          } else if (rota == "Historico") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CalculadoraHistorico()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TempoConverter()));
          }
        },
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
