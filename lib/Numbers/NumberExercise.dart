import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class NumberExercise extends StatefulWidget {
  @override
  _NumberExerciseState createState() => _NumberExerciseState();
}

class _NumberExerciseState extends State<NumberExercise> {
  final AudioPlayer player = AudioPlayer();
  String currentNumber = '';
  String selectedNumber = '';
  bool isCorrectAnswer = false;
  bool isFirstTime = true;
  bool isListenButtonPressed = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;

  List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  Map<String, String> numberAudios = {
    '0': 'audio/zero.mp3',
    '1': 'audio/one.mp3',
    '2': 'audio/two.mp3',
    '3': 'audio/three.mp3',
    '4': 'audio/four.mp3',
    '5': 'audio/five.mp3',
    '6': 'audio/six.mp3',
    '7': 'audio/seven.mp3',
    '8': 'audio/eight.mp3',
    '9': 'audio/nine.mp3'
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void speakRandomNumber() {
    if (isFirstTime) {
      isFirstTime = false; // Set the flag to false after speaking the number
    }
    Random random = Random();
    int index = random.nextInt(numbers.length);
    String number = numbers[index];
    playSound(numberAudios[number] ?? '');
    setState(() {
      currentNumber = number;
      selectedNumber = '';
      isCorrectAnswer = false;
    });
  }

  void checkAnswer(String number) {
    if (!isListenButtonPressed) {
      // Show alert if user tries to select number without pressing "Listen" button
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(fontFamily: 'openDyslexic', color: Colors.red),
          ),
          content: Text('Please listen to the number first.',
              style: TextStyle(fontFamily: 'openDyslexic', fontSize: 16)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      totalQuestionsAttempted++;
      selectedNumber = number;
      isCorrectAnswer = number == currentNumber;
    });
    if (isCorrectAnswer) {
      totalCorrectAnswers++;
      playSound("audio/yay.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Correct Answer!',
              style:
                  TextStyle(color: Colors.green, fontFamily: 'OpenDyslexic')),
          content: Image.asset(
            "images/Monkey2.gif",
            width: 150,
            height: 150,
          ),
        ),
      ).then((value) {
        setState(() {
          selectedNumber = '';
          isCorrectAnswer = false;
        });
      });
    } else {
      totalWrongAnswers++;
      playSound("audio/wrong.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Wrong Answer!',
            style: TextStyle(color: Colors.red, fontFamily: 'openDyslexic'),
          ),
          content: Image.asset(
            "images/tomwrong.gif",
            width: 150,
            height: 150,
          ),
        ),
      ).then((value) {
        setState(() {
          selectedNumber = '';
          isCorrectAnswer = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Exercise',
            style: TextStyle(
                color: Colors.black, fontFamily: 'openDyslexic', fontSize: 25)),
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
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            speakRandomNumber();
                            setState(() {
                              isListenButtonPressed = true;
                            });
                          },
                          child: Text('Listen'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: currentNumber.isNotEmpty
                              ? () =>
                                  playSound(numberAudios[currentNumber] ?? '')
                              : null,
                          child: Text('Listen Again'),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Listen and Select the correct number:',
                      style:
                          TextStyle(fontSize: 17, fontFamily: 'openDyslexic'),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: numbers.map((number) {
                        return GestureDetector(
                          onTap: () {
                            if (!isCorrectAnswer) {
                              checkAnswer(number);
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedNumber == number
                                  ? (isCorrectAnswer
                                      ? Colors.green
                                      : Colors.red)
                                  : Colors.blue,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              number,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'openDyslexic'),
                            ),
                          ),
                        );
                      }).toList(),
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
