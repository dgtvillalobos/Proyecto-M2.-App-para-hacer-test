// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto2/main.dart';

class paginaCineArte extends StatefulWidget {
  String text;
  String answer;

  paginaCineArte(this.text, this.answer, {super.key});

  static List<paginaCineArte> questions = [
    paginaCineArte(
        'La película "El Padrino" fue dirigida por Steven Spielberg.', 'Falso'),
    paginaCineArte('Leonardo da Vinci pintó la Mona Lisa.', 'Verdadero'),
    paginaCineArte(
        'El actor Tom Hanks interpretó a Forrest Gump en la película del mismo nombre.',
        'Verdadero'),
    paginaCineArte(
        'La película "Casablanca" fue lanzada en la década de 1970.', 'Falso'),
    paginaCineArte(
        'El director Quentin Tarantino dirigió la película "Pulp Fiction".',
        'Verdadero'),
    paginaCineArte(
        'La película "El Señor de los Anillos" está basada en una novela de J.K. Rowling.',
        'Falso'),
    paginaCineArte(
        'El pintor español Salvador Dalí fue conocido por su estilo surrealista.',
        'Verdadero'),
    paginaCineArte(
        'El actor Heath Ledger interpretó a Batman en la trilogía de "The Dark Knight".',
        'Falso'),
    paginaCineArte(
        'La película "Titanic" fue dirigida por James Cameron.', 'Verdadero'),
    paginaCineArte(
        'Vincent van Gogh cortó su oreja como resultado de una pelea con otro pintor.',
        'Verdadero'),
    paginaCineArte(
        'El actor Johnny Depp interpretó a Jack Sparrow en la serie de películas "Piratas del Caribe".',
        'Verdadero'),
    paginaCineArte(
        'El cineasta mexicano Guillermo del Toro dirigió la película "Gravity".',
        'Falso'),
    paginaCineArte(
        'La obra de arte "La Noche Estrellada" fue creada por Pablo Picasso.',
        'Falso'),
    paginaCineArte(
        'La película "El Rey León" es una película animada de Disney.',
        'Verdadero'),
    paginaCineArte(
        'La actriz Meryl Streep ha ganado más premios Oscar que cualquier otro actor o actriz.',
        'Verdadero'),
  ];

  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<paginaCineArte> {
  List<int> indicePreguntaSelecciona = [];
  List<paginaCineArte> preguntaSeleccionada = [];

  void initializeSelectedQuestions() {
    Random random = Random();
    while (indicePreguntaSelecciona.length < 5) {
      int randomIndex = random.nextInt(paginaCineArte.questions.length);
      if (!indicePreguntaSelecciona.contains(randomIndex)) {
        indicePreguntaSelecciona.add(randomIndex);
        preguntaSeleccionada.add(paginaCineArte.questions[randomIndex]);
      }
    }
  }

  int Index = 0;
  int totalPuntos = 0;
  List<paginaCineArte> preguntasCorrectas = [];

  @override
  void initState() {
    super.initState();
    initializeSelectedQuestions();
  }

  void respuesta(bool answer) {
    setState(() {
      paginaCineArte pregunta = preguntaSeleccionada[Index];

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
                              builder: (context) => paginaCineArte('', '')),
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
        backgroundColor: Color.fromARGB(255, 207, 132, 223),
        title: const Text(
          'Página Cine Arte',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 172, 21, 209),
              Color.fromARGB(255, 196, 147, 15)
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
