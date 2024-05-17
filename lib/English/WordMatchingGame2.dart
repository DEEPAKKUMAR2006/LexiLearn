import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WordMatchingGame2 extends StatefulWidget {
  @override
  _WordMatchingGameState createState() => _WordMatchingGameState();
}

class _WordMatchingGameState extends State<WordMatchingGame2> {
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
    'xylophone',
    'yatch',
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
    'umbrella stand',
    'violin',
    'window',
    'yak',
    'zucchini'
  ];
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
    'xylophone.png',
    'yatch.png',
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
    'umbrella stand.png',
    'violin.png',
    'window.png',
    'yak.png',
    'zucchini.png'
  ];
  String selectedWord = '';
  String selectedImage = '';
  List<String> displayedImages = [];
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
      Random random = Random();
      int index = random.nextInt(words.length);
      selectedWord = words[index];
      selectedImage = images[index];

      displayedImages.clear();
      displayedImages.add(selectedImage);

      while (displayedImages.length < 4) {
        String randomImage = images[random.nextInt(images.length)];
        if (!displayedImages.contains(randomImage)) {
          displayedImages.add(randomImage);
        }
      }

      displayedImages.shuffle();
      isCorrect = false;
    });
  }

  void checkMatch(String image) {
    setState(() {
      totalQuestionsAttempted++;
      isCorrect = image == selectedImage;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Quest",
          style: TextStyle(fontFamily: 'openDyslexic'),
        ),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Choose the correct Image:',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'openDyslexic',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    Text(
                      selectedWord.toUpperCase(),
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'openDyslexic',
                          fontWeight: FontWeight.bold),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: List.generate(displayedImages.length, (index) {
                        String image = displayedImages[index];
                        return GestureDetector(
                          onTap: () {
                            if (!isCorrect) {
                              checkMatch(image);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              "images2/$image",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        _setNextQuestion();
                      },
                      child: Text('Refresh'),
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
