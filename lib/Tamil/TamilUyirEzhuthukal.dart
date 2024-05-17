import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TamilAlphabetListeningPage extends StatefulWidget {
  @override
  _TamilAlphabetListeningPageState createState() =>
      _TamilAlphabetListeningPageState();
}

class _TamilAlphabetListeningPageState
    extends State<TamilAlphabetListeningPage> {
  final AudioPlayer player = AudioPlayer();
  String currentAlphabet = '';
  String selectedAlphabet = '';
  bool isCorrectAnswer = false;
  bool isFirstTime = false;
  bool isListenButtonPressed = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;

  List<String> alphabets = [
    'அ',
    'ஆ',
    'இ',
    'ஈ',
    'உ',
    'ஊ',
    'எ',
    'ஏ',
    'ஐ',
    'ஒ',
    'ஓ',
    'ஔ'
  ];

  Map<String, String> alphabetAudios = {
    'அ': 'audio/அ.mp3',
    'ஆ': 'audio/ஆ.mp3',
    'இ': 'audio/இ.mp3',
    'ஈ': 'audio/ஈ.mp3',
    'உ': 'audio/உ.mp3',
    'ஊ': 'audio/ஊ.mp3',
    'எ': 'audio/எ.mp3',
    'ஏ': 'audio/ஏ.mp3',
    'ஐ': 'audio/ஐ.mp3',
    'ஒ': 'audio/ஒ.mp3',
    'ஓ': 'audio/ஓ.mp3',
    'ஔ': 'audio/ஔ.mp3'
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void speakRandomAlphabet() {
    if (isFirstTime) {
      isFirstTime = false; // Set the flag to false after speaking the number
    }
    Random random = Random();
    int index = random.nextInt(alphabets.length);
    String alphabet = alphabets[index];
    playSound(alphabetAudios[alphabet] ?? '');
    setState(() {
      currentAlphabet = alphabet;
      selectedAlphabet = '';
      isCorrectAnswer = false;
    });
  }

  void checkAnswer(String alphabet) {
    if (!isListenButtonPressed) {
      // Show alert if user tries to select number without pressing "Listen" button
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('எச்சரிக்கை', style: TextStyle(color: Colors.red)),
          content:
              Text('முதலில் எழுத்தை கேளுங்கள்', style: TextStyle(fontSize: 16)),
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
      selectedAlphabet = alphabet;
      isCorrectAnswer = alphabet == currentAlphabet;
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
          selectedAlphabet = '';
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
          selectedAlphabet = '';
          isCorrectAnswer = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      speakRandomAlphabet();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'உயிரெழுத்து பயிற்சி',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            speakRandomAlphabet();
                            setState(() {
                              isListenButtonPressed = true;
                            });
                          },
                          child: Text('கேள்'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: currentAlphabet.isNotEmpty
                              ? () => playSound(
                                  alphabetAudios[currentAlphabet] ?? '')
                              : null,
                          child: Text('மீண்டும் கேள்'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'சரியான எழுத்தை தேர்வு செய்யவும்:',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: alphabets.map((alphabet) {
                        return GestureDetector(
                          onTap: () {
                            if (!isCorrectAnswer) {
                              checkAnswer(alphabet);
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedAlphabet == alphabet
                                  ? (isCorrectAnswer
                                      ? Colors.green
                                      : Colors.red)
                                  : Colors.blue,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              alphabet,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
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
