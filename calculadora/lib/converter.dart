import 'package:calculadora/historico.dart';
import 'package:calculadora/main.dart';
import 'package:flutter/material.dart';

class CalculadoraConverter extends StatefulWidget {
  const CalculadoraConverter({super.key});

  @override
  CalculadoraConverterState createState() => CalculadoraConverterState();
}

class CalculadoraConverterState extends State<CalculadoraConverter> {
  @override
  Widget build(BuildContext context) {
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
                  cor: Color(0xFF2D3440),
                  rota: 'Calculador'),
              BotaoSuperior(
                  label: 'Converter',
                  cor: Color(0xFF0060E5),
                  rota: 'Converter'),
              BotaoSuperior(
                  label: 'Historico',
                  cor: Color(0xFF2D3440),
                  rota: 'Historico'),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      ConverterOpcoes(label: 'Idade'),
                      const SizedBox(width: 20),
                      ConverterOpcoes(label: 'Área'),
                      const SizedBox(width: 20),
                      ConverterOpcoes(label: 'Massa'),
                      const SizedBox(width: 20),
                      ConverterOpcoes(label: 'Comprimento'),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
          } else if (rota == "Historico") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalculadoraHistorico()));
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

class ConverterOpcoes extends StatelessWidget {
  final String label;
  final double largura;
  final double altura;

  ConverterOpcoes({required this.label, this.largura = 120, this.altura = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: largura,
      height: altura,
      decoration: BoxDecoration(
        color: const Color(0xFFB388FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          print('teste');
        },
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
