import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MathGame extends StatefulWidget {
  @override
  _MathGameState createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  final AudioPlayer player = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  int firstNumber = 0;
  int secondNumber = 0;
  String selectedOperator = '';
  int correctAnswer = 0;
  List<int> options = [];
  bool isCorrect = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;
  bool isVolumeEnabled = true;
  String difficulty = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showDifficultyDialog();
    });
  }

  void _showDifficultyDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Choose Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  difficulty = 'Easy';
                });
                Navigator.pop(context);
                _setNextQuestion();
              },
              child: Text('Easy'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  difficulty = 'Medium';
                });
                Navigator.pop(context);
                _setNextQuestion();
              },
              child: Text('Medium'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  difficulty = 'Hard';
                });
                Navigator.pop(context);
                _setNextQuestion();
              },
              child: Text('Hard'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  difficulty = 'Godmode';
                });
                Navigator.pop(context);
                _setNextQuestion();
              },
              child: Text('Godmode'),
            ),
          ],
        ),
      ),
    );
  }

  void _setNextQuestion() {
    setState(() {
      totalQuestionsAttempted++;
      isCorrect = false; // Reset correctness flag
    });

    switch (difficulty) {
      case 'Easy':
        {
          firstNumber = Random().nextInt(10) + 1;
          secondNumber = Random().nextInt(10) + 1;
          break;
        }
      case 'Medium':
        {
          firstNumber = Random().nextInt(10) + 11;
          secondNumber = Random().nextInt(10) + 11;
          break;
        }
      case 'Hard':
        {
          firstNumber = Random().nextInt(79) + 21;
          secondNumber = Random().nextInt(79) + 21;
          break;
        }
      case 'Godmode':
        {
          firstNumber = Random().nextInt(900) + 100;
          secondNumber = Random().nextInt(900) + 100;
          break;
        }
    }

    switch (Random().nextInt(4)) {
      case 0:
        selectedOperator = '+';
        correctAnswer = firstNumber + secondNumber;
        break;
      case 1:
        selectedOperator = '-';
        if (firstNumber < secondNumber) {
          int temp = firstNumber;
          firstNumber = secondNumber;
          secondNumber = temp;
        }
        correctAnswer = firstNumber - secondNumber;
        break;
      case 2:
        selectedOperator = '×';
        correctAnswer = firstNumber * secondNumber;
        break;
      case 3:
        selectedOperator = '÷';
        if (firstNumber < secondNumber) {
          int temp = firstNumber;
          firstNumber = secondNumber;
          secondNumber = temp;
        }
        correctAnswer = firstNumber ~/ secondNumber;
        break;
    }

    // Generate incorrect options
    options = [];
    while (options.length < 3) {
      int randomOption = Random().nextInt(correctAnswer + 20) + 1;
      if (randomOption != correctAnswer && !options.contains(randomOption)) {
        options.add(randomOption);
      }
    }

    // Add correct option to the list
    options.add(correctAnswer);
    options.shuffle();
  }

  void checkAnswer(int answer) {
    setState(() {
      isCorrect = answer == correctAnswer;
    });

    if (isCorrect) {
      totalCorrectAnswers++;
      _playSound("audio/yay.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Correct Answer!',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'OpenDyslexic',
            ),
          ),
          content: Image.asset(
            "images/Monkey2.gif",
            width: 150,
            height: 150,
          ),
        ),
      );
    } else {
      totalWrongAnswers++;
      _playSound("audio/wrong.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Wrong Answer!',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'openDyslexic',
            ),
          ),
          content: Image.asset(
            "images/tomwrong.gif",
            width: 150,
            height: 150,
          ),
        ),
      );
    }
  }

  Future<void> _playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Math Exercise',
          style: TextStyle(fontFamily: 'openDyslexic'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      'Solve the Math Equation:',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'openDyslexic',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$firstNumber $selectedOperator $secondNumber = ?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'openDyslexic',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: options.map((int option) {
                        return GestureDetector(
                          onTap: () {
                            if (!isCorrect) {
                              checkAnswer(option);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: () {
                                  if (!isCorrect) {
                                    checkAnswer(option);
                                  }
                                },
                                child: SizedBox(
                                  width: 150,
                                  height: 80,
                                  child: Center(
                                    child: Text(
                                      '$option',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'openDyslexic',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _setNextQuestion();
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Progress Report'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: totalCorrectAnswers / totalQuestionsAttempted >= 0.6
                        ? Colors.green
                        : Colors.red,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Score: ${(totalCorrectAnswers / totalQuestionsAttempted * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: charts.BarChart(
                      _createSampleData(),
                      animate: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Total Questions Attempted: $totalQuestionsAttempted'),
                  Text('Total Correct Answers: $totalCorrectAnswers'),
                  Text('Total Wrong Answers: $totalWrongAnswers'),
                ],
              ),
            ),
          );
        },
        child: Icon(Icons.bar_chart),
      ),
    );
  }

  List<charts.Series<ProgressData, String>> _createSampleData() {
    final List<ProgressData> data = [
      ProgressData('Correct', totalCorrectAnswers),
      ProgressData('Wrong', totalWrongAnswers),
    ];

    return [
      charts.Series<ProgressData, String>(
        id: 'Progress',
        domainFn: (ProgressData progress, _) => progress.status,
        measureFn: (ProgressData progress, _) => progress.value,
        data: data,
        colorFn: (ProgressData progress, _) {
          if (progress.status == 'Correct') {
            return charts.MaterialPalette.green.shadeDefault;
          } else {
            return charts.MaterialPalette.red.shadeDefault;
          }
        },
        labelAccessorFn: (ProgressData progress, _) =>
            '${progress.status}: ${progress.value}',
      )
    ];
  }
}

class ProgressData {
  final String status;
  final int value;

  ProgressData(this.status, this.value);
}

void main() {
  runApp(MaterialApp(
    home: MathGame(),
  ));
}
