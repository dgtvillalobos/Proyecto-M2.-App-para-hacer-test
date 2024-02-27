// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto2/main.dart';

class paginaMatematica extends StatefulWidget {
  String text;
  String answer;

  paginaMatematica(this.text, this.answer, {super.key});

  static List<paginaMatematica> questions = [
    paginaMatematica('2 + 2 = 5', 'Falso'),
    paginaMatematica('6 x 6 = 36', 'Verdadero'),
    paginaMatematica('8 + 8 = 18', 'Falso'),
    paginaMatematica('1 + 2 = 3', 'Verdadero'),
    paginaMatematica('1 x 2 = 3', 'Falso'),
    paginaMatematica('1999 + 2 = 2001', 'Verdadero'),
    paginaMatematica('13 + 13 = 1313', 'Falso'),
    paginaMatematica('1 x 1 = 2', 'Falso'),
    paginaMatematica('1 - 100 = 99', 'Verdadero'),
    paginaMatematica('100 - 100 = 0', 'Verdadero'),
    paginaMatematica('1000 / 2 = 500', 'Verdadero'),
    paginaMatematica('10 / 1 = 9', 'Falso'),
    paginaMatematica('100 / 100 = 11', 'Falso'),
    paginaMatematica('1000 / 1000 = 1', 'Verdadero'),
    paginaMatematica('10 / 1 = 10', 'Verdadero'),
  ];

  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<paginaMatematica> {
  List<int> indicePreguntaSelecciona = [];
  List<paginaMatematica> preguntaSeleccionada = [];

  void initializeSelectedQuestions() {
    Random random = Random();
    while (indicePreguntaSelecciona.length < 5) {
      int randomIndex = random.nextInt(paginaMatematica.questions.length);
      if (!indicePreguntaSelecciona.contains(randomIndex)) {
        indicePreguntaSelecciona.add(randomIndex);
        preguntaSeleccionada.add(paginaMatematica.questions[randomIndex]);
      }
    }
  }

  int Index = 0;
  int totalPuntos = 0;
  List<paginaMatematica> preguntasCorrectas = [];

  @override
  void initState() {
    super.initState();
    initializeSelectedQuestions();
  }

  void respuesta(bool answer) {
    setState(() {
      paginaMatematica pregunta = preguntaSeleccionada[Index];

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
                              builder: (context) => paginaMatematica('', '')),
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
        backgroundColor: const Color.fromARGB(255, 3, 83, 148),
        title: const Text(
          'Página Matemáticas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 33, 120, 190), Colors.blueGrey],
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
