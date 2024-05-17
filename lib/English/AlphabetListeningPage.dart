import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AlphabetListeningPage extends StatefulWidget {
  @override
  _AlphabetListeningPageState createState() => _AlphabetListeningPageState();
}

class _AlphabetListeningPageState extends State<AlphabetListeningPage> {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer player = AudioPlayer();
  String currentAlphabet = '';
  String selectedAlphabet = '';
  bool isCorrectAnswer = false;
  bool isFirstTime = true; // Flag to control speaking alphabet at the start
  bool isListenButtonPressed =
      false; // Flag to track if "Listen" button is pressed
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;

  List<String> alphabets = List.generate(
      26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound(String audiopath) async {
    await flutterTts.setSpeechRate(0.2);
    await player.play(AssetSource(audiopath));
  }

  void speakRandomAlphabet() async {
    if (isFirstTime) {
      isFirstTime = false; // Set the flag to false after speaking the alphabet
    }
    Random random = Random();
    int index = random.nextInt(alphabets.length);
    String alphabet = alphabets[index];
    await flutterTts.speak(alphabet);
    setState(() {
      currentAlphabet = alphabet;
      selectedAlphabet = '';
      isCorrectAnswer = false;
    });
  }

  void checkAnswer(String alphabet) {
    if (!isListenButtonPressed) {
      // Show alert if user tries to select letter without pressing "Listen" button
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Alert',
              style: TextStyle(color: Colors.red, fontFamily: 'OpenDyslexic')),
          content: Text('Please listen to the alphabet first.',
              style: TextStyle(fontFamily: 'OpenDyslexic')),
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

  void speakSoundAlphabet(String alphabet) async {
    await flutterTts.speak(alphabet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alphabet Listening',
          style: TextStyle(color: Colors.black, fontFamily: 'OpenDyslexic'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow below the app bar
      ),
      extendBodyBehindAppBar:
          true, // Extend the background image behind the app bar
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
                          child: Text('Listen'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: isListenButtonPressed
                              ? () => speakSoundAlphabet(currentAlphabet)
                              : null,
                          child: Text('Listen Again'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select the correct alphabet:',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily:
                              'OpenDyslexic'), // Apply OpenDyslexic font
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
                              alphabet.toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontFamily:
                                    'OpenDyslexic', // Apply OpenDyslexic font
                              ),
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
