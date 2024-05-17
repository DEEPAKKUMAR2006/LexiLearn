import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WordMatchingGame extends StatefulWidget {
  @override
  _WordMatchingGameState createState() => _WordMatchingGameState();
}

class _WordMatchingGameState extends State<WordMatchingGame> {
  final AudioPlayer player = AudioPlayer();
  List<String> words = [
    'apple',
    'backpack',
    'candle',
    'desk',
    'earphones',
    'flower',
    'glasses',
    'hat',
    'ice cream',
    'jacket',
    'kettle',
    'lamp',
    'notebook',
    'orange',
    'pillow',
    'quilt',
    'ring',
    'scissors',
    'television',
    'umbrella',
    'vase',
    'wallet',
    'xerox machine',
    'yogurt',
    'zipper',
    'banana',
    'chair',
    'door',
    'fan',
    'grapes',
    'helmet',
    'iron',
    'jeans',
    'knife',
    'lemon',
    'mirror',
    'nail',
    'oven',
    'pen',
    'queue',
    'refrigerator',
    'spoon',
    'table',
    'usb',
    'vehicle',
    'watch',
    'zebra crossing',
    'alarm clock',
    'broom',
    'computer',
    'dishwasher',
    'eraser',
    'frying pan',
    'guitar',
    'hammer',
    'ice tray',
    'jug',
    'key',
    'light bulb',
    'mouse',
    'note',
    'piano',
    'quiver',
    'roller',
    'sandwich',
    'toaster',
    'umbrella stand',
    'violin',
    'window',
    // Add more words here...
  ];
  List<String> shuffledWords = [];
  List<String> images = [
    'apple.png',
    'backpack.png',
    'candle.png',
    'desk.png',
    'earphones.png',
    'flower.png',
    'glasses.png',
    'hat.png',
    'ice cream.png',
    'jacket.png',
    'kettle.png',
    'lamp.png',
    'notebook.png',
    'orange.png',
    'pillow.png',
    'quilt.png',
    'ring.png',
    'scissors.png',
    'television.png',
    'umbrella.png',
    'vase.png',
    'wallet.png',
    'xerox machine.png',
    'yogurt.png',
    'zipper.png',
    'banana.png',
    'chair.png',
    'door.png',
    'fan.png',
    'grapes.png',
    'helmet.png',
    'iron.png',
    'jeans.png',
    'knife.png',
    'lemon.png',
    'mirror.png',
    'nail.png',
    'oven.png',
    'pen.png',
    'queue.png',
    'refrigerator.png',
    'spoon.png',
    'table.png',
    'usb.png',
    'vehicle.png',
    'watch.png',
    'zebra crossing.png',
    'alarm clock.png',
    'broom.png',
    'computer.png',
    'dishwasher.png',
    'eraser.png',
    'frying pan.png',
    'guitar.png',
    'hammer.png',
    'ice tray.png',
    'jug.png',
    'key.png',
    'light bulb.png',
    'mouse.png',
    'note.png',
    'piano.png',
    'quiver.png',
    'roller.png',
    'sandwich.png',
    'toaster.png',
    'umbrella stand.png',
    'violin.png',
    'window.png',

    // Add corresponding image paths here...
  ];
  String selectedWord = '';
  String selectedImage = '';
  List<String> answerOptions = [];
  bool isCorrect = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;

  @override
  void initState() {
    super.initState();
    _setNextQuestion();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void _setNextQuestion() {
    setState(() {
      shuffledWords = List.from(words);
      shuffledWords.shuffle();
      selectedWord = shuffledWords[0];
      selectedImage = images[words.indexOf(selectedWord)];

      answerOptions.clear();
      answerOptions.add(selectedWord);

      // Add two random incorrect answers
      Random random = Random();
      while (answerOptions.length < 3) {
        String randomWord = words[random.nextInt(words.length)];
        if (!answerOptions.contains(randomWord)) {
          answerOptions.add(randomWord);
        }
      }

      answerOptions.shuffle();
      isCorrect = false; // Reset correctness flag
    });
  }

  void checkMatch(String word) {
    setState(() {
      totalQuestionsAttempted++;
      isCorrect = word == selectedWord;
    });
    if (isCorrect) {
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
      );
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Word Quest!', style: TextStyle(fontFamily: 'OpenDyslexic')),
        backgroundColor: Colors.transparent,
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
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose the correct word!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'OpenDyslexic', // Apply OpenDyslexic font
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        checkMatch(selectedWord);
                      },
                      child: Image.asset(
                        "images2/$selectedImage",
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: answerOptions.map((word) {
                        return GestureDetector(
                          onTap: () {
                            if (!isCorrect) {
                              checkMatch(word);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isCorrect && word == selectedWord
                                  ? Colors.green
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              word.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily:
                                    'OpenDyslexic', // Apply OpenDyslexic font
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _setNextQuestion();
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 20),
                      ),
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
