import 'package:calculadora/converter.dart';
import 'package:calculadora/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CalculadoraInvestimento extends StatefulWidget {
  const CalculadoraInvestimento({super.key});

  @override
  CalculadoraInvestimentoState createState() => CalculadoraInvestimentoState();
}

class CalculadoraInvestimentoState extends State<CalculadoraInvestimento> {
  bool isUnico = true;
  TextEditingController investimentoController = TextEditingController();
  TextEditingController jurosController = TextEditingController();
  int duracaoAnos = 1;
  int duracaoMeses = 0;
  double? resultado;

  void calcularInvestimento() {
    double investimento = double.tryParse(investimentoController.text) ?? 0;
    double juros = (double.tryParse(jurosController.text) ?? 0) / 100;
    int totalMeses = (duracaoAnos * 12) + duracaoMeses;
    double montante;

    if (isUnico) {
      montante = investimento * (1 + juros * totalMeses / 12);
    } else {
      montante = investimento *
          ((pow(1 + juros, totalMeses) - 1) / juros);
    }

    setState(() {
      resultado = montante;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BotaoSuperior(
                    label: 'Calculadora',
                    cor: Color(0xFF2D3440),
                    rota: 'Calculador',
                  ),
                  SizedBox(width: 6), 
                  BotaoSuperior(
                    label: 'Converter',
                    cor: Color(0xFF2D3440),
                    rota: 'Converter',
                  ),
                  SizedBox(width: 6), 
                  BotaoSuperior(
                    label: 'Investimento',
                    cor: Color(0xFF0060E5),
                    rota: 'Investimento',
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: Text('Único', style: TextStyle(color: Colors.white)),
                      value: true,
                      groupValue: isUnico,
                      onChanged: (value) {
                        setState(() {
                          isUnico = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: Text('Recorrente', style: TextStyle(color: Colors.white)),
                      value: false,
                      groupValue: isUnico,
                      onChanged: (value) {
                        setState(() {
                          isUnico = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Investimento total', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  TextField(
                    controller: investimentoController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Juros (porcentagem)', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  TextField(
                    controller: jurosController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duração', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) {
                          return DuracaoDialog(
                            anos: duracaoAnos,
                            meses: duracaoMeses,
                          );
                        },
                      );
                      if (result != null) {
                        setState(() {
                          duracaoAnos = result['anos'];
                          duracaoMeses = result['meses'];
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: '$duracaoAnos ano(s) e $duracaoMeses mês(es)',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: calcularInvestimento,
                child: Text(
                  'Calcular',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              if (resultado != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Resultado: ${resultado!.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
            ],
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

  BotaoSuperior({
    required this.label,
    required this.cor,
    this.rota = '',
    this.largura = 115,
    this.altura = 50,
  });

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

class DuracaoDialog extends StatefulWidget {
  final int anos;
  final int meses;

  DuracaoDialog({required this.anos, required this.meses});

  @override
  _DuracaoDialogState createState() => _DuracaoDialogState();
}

class _DuracaoDialogState extends State<DuracaoDialog> {
  late int anos;
  late int meses;

  @override
  void initState() {
    super.initState();
    anos = widget.anos;
    meses = widget.meses;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selecione a duração'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Anos:'),
              SizedBox(width: 16),
              DropdownButton<int>(
                value: anos,
                items: List.generate(30, (index) => index).map((value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    anos = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Meses:'),
              SizedBox(width: 16),
              DropdownButton<int>(
                value: meses,
                items: List.generate(12, (index) => index).map((value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    meses = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({'anos': anos, 'meses': meses});
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
