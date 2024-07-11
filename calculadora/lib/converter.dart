import 'package:calculadora/converterOptions/idade.dart';
import 'package:calculadora/converterOptions/tempo.dart';
import 'package:calculadora/converterOptions/velocidade.dart';
import 'package:calculadora/investimento.dart';
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
                  cor: const Color(0xFF2D3440),
                  rota: 'Calculadora'),
              BotaoSuperior(
                  label: 'Converter',
                  cor: const Color(0xFF0060E5),
                  rota: 'Converter'),
              BotaoSuperior(
                  label: 'Investimento',
                  cor: const Color(0xFF2D3440),
                  rota: 'Investimento'),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 35,
                    alignment: WrapAlignment.center,
                    children: [
                      ConverterOpcoes(
                        label: 'Idade',
                        icon: Icons.calendar_today,
                        largura: (MediaQuery.of(context).size.width / 3) - 24,
                        altura: 80,
                      ),
                      ConverterOpcoes(
                        label: 'Tempo',
                        icon: Icons.schedule,
                        largura: (MediaQuery.of(context).size.width / 3) - 24,
                        altura: 80,
                      ),
                      ConverterOpcoes(
                        label: 'Velocidade',
                        icon: Icons.speed,
                        largura: (MediaQuery.of(context).size.width / 3) - 24,
                        altura: 80,
                      ),
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
                    builder: (context) => const CalculadoraConverter()));
          } else if (rota == "Investimento") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CalculadoraInvestimento()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CalculadoraApp()));
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

class ConverterOpcoes extends StatelessWidget {
  final String label;
  final IconData icon;
  final double largura;
  final double altura;

  ConverterOpcoes(
      {required this.label,
      required this.icon,
      required this.largura,
      required this.altura});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == "Idade") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const IdadeConverter()));
        } else if (label == "Tempo") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TempoConverter()));
        } else if (label == "Velocidade") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const VelocidadeConverter()));
        }
      },
      child: Container(
        width: largura,
        height: altura,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
