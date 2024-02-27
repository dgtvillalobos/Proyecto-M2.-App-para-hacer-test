// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto2/main.dart';

class paginaCiencias extends StatefulWidget {
  String text;
  String answer;

  paginaCiencias(this.text, this.answer, {super.key});

  static List<paginaCiencias> questions = [
    paginaCiencias(
        '¿El oxígeno es el elemento más abundante en la Tierra?', 'Falso'),
    paginaCiencias('¿La Tierra gira alrededor del Sol?', 'Verdadero'),
    paginaCiencias('¿Los humanos evolucionaron de los chimpancés?', 'Falso'),
    paginaCiencias(
        '¿El agua hierve a 100 grados Celsius a nivel del mar?', 'Verdadero'),
    paginaCiencias('¿El ADN es una molécula de doble hélice?', 'Verdadero'),
    paginaCiencias('¿El sol gira alrededor de la Tierra?', 'Falso'),
    paginaCiencias('¿Las bacterias son organismos multicelulares?', 'Falso'),
    paginaCiencias('¿Los átomos son indivisibles?', 'Falso'),
    paginaCiencias('¿La ley de la gravedad fue descubierta por Isaac Newton?',
        'Verdadero'),
    paginaCiencias('¿Los mamíferos ponen huevos?', 'Falso'),
    paginaCiencias('¿La Luna tiene su propia luz?', 'Falso'),
  ];

  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<paginaCiencias> {
  List<int> indicePreguntaSelecciona = [];
  List<paginaCiencias> preguntaSeleccionada = [];

  void initializeSelectedQuestions() {
    Random random = Random();
    while (indicePreguntaSelecciona.length < 5) {
      int randomIndex = random.nextInt(paginaCiencias.questions.length);
      if (!indicePreguntaSelecciona.contains(randomIndex)) {
        indicePreguntaSelecciona.add(randomIndex);
        preguntaSeleccionada.add(paginaCiencias.questions[randomIndex]);
      }
    }
  }

  int Index = 0;
  int totalPuntos = 0;
  List<paginaCiencias> preguntasCorrectas = [];

  @override
  void initState() {
    super.initState();
    initializeSelectedQuestions();
  }

  void respuesta(bool answer) {
    setState(() {
      paginaCiencias pregunta = preguntaSeleccionada[Index];

      if ((answer && pregunta.answer == 'Verdadero') ||
          (!answer && pregunta.answer == 'Falso')) {
        totalPuntos++;
        preguntasCorrectas.add(pregunta);
      }

      Index++;

      if (Index >= preguntaSeleccionada.length) {
        Index = 0;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text('Resultados')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check, color: Colors.green),
                  const Center(
                      child: Text('Has respondido todas las preguntas.')),
                  Center(child: Text('Total de puntos: $totalPuntos')),
                  const Center(child: Text('(Puntaje Maxímo: 5)')),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Preguntas respondidas correctamente',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 33, 120, 190),
                    ),
                    child: SizedBox(
                      height: preguntasCorrectas.length * 55,
                      width: 350,
                      child: ListView.builder(
                        itemCount: preguntasCorrectas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Center(
                              child: Text(
                                '${index + 1}. ${preguntasCorrectas[index].text} - ${preguntasCorrectas[index].answer}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => paginaCiencias('', '')),
                        );
                      },
                      child: const Text('Reintentar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: '',
                                  )),
                        );
                      },
                      child: const Text('Volver al inicio'),
                    ),
                  ],
                )
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String preguntaSelect = preguntaSeleccionada[Index].text;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 165, 50),
        title: const Text(
          'Página Ciencias',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 29, 143, 14),
              Color.fromARGB(255, 196, 128, 52)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                preguntaSelect,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      respuesta(true);
                    },
                    child: const Text('Verdadero'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      respuesta(false);
                    },
                    child: const Text('Falso'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
