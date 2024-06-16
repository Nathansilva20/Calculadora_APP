import 'package:calculadora/converter.dart';
import 'package:calculadora/main.dart';
import 'package:flutter/material.dart';

class CalculadoraHistorico extends StatefulWidget {
  const CalculadoraHistorico({super.key});

  @override
  CalculadoraHistoricoState createState() => CalculadoraHistoricoState();
}

class CalculadoraHistoricoState extends State<CalculadoraHistorico> {
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
                  cor: Color(0xFF0060E5),
                  rota: 'Calculador'),
              BotaoSuperior(
                  label: 'Converter',
                  cor: Color(0xFF2D3440),
                  rota: 'Converter'),
              BotaoSuperior(
                  label: 'Historico',
                  cor: Color(0xFF2D3440),
                  rota: 'Historico'),
            ],
          )
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
