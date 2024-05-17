import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MonkeyCountingPage(),
    );
  }
}

class MonkeyCountingPage extends StatefulWidget {
  @override
  _MonkeyCountingPageState createState() => _MonkeyCountingPageState();
}

class _MonkeyCountingPageState extends State<MonkeyCountingPage> {
  int monkeyCount = 0;
  int correctAnswerIndex = 0;
  List<String> options = [];
  AudioPlayer player = AudioPlayer();
  int totalQuestionsAttempted = 1;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;
  @override
  void initState() {
    super.initState();
    generateMonkeyCount();
  }

  void generateMonkeyCount() {
    Random random = Random();
    monkeyCount = random.nextInt(9) + 1; // Generate random count from 1 to 9
    correctAnswerIndex =
        random.nextInt(4); // Randomly select correct answer index
    List<String> allOptions = List.generate(9, (index) => '${index + 1}');
    allOptions.remove('$monkeyCount');

    options = allOptions..shuffle();
    options = options.sublist(0, 3);
    options.insert(correctAnswerIndex, '$monkeyCount'); // Set correct option
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Monkey Counting Game',
          style: TextStyle(fontFamily: 'openDyslexic'),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Adjusted padding here
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0), // Adjusted padding here
                  child: Text(
                    'Select the correct number of monkeys',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'openDyslexic',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center, // Center the text
                  ),
                ),
                SizedBox(height: 10),
                // Display monkey image multiple times based on monkey count
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: monkeyCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'images/monkey.png', // Replace with actual image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                // Display options for user to select
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: options
                      .asMap()
                      .entries
                      .map(
                        (entry) => ElevatedButton(
                          onPressed: () {
                            if (entry.key == correctAnswerIndex) {
                              totalCorrectAnswers++;
                              // User selected correct option
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Correct Answer!',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'OpenDyslexic')),
                                  content: Image.asset(
                                    "images/Monkey2.gif",
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                              );
                              playSound("audio/yay.mp3");
                            } else {
                              totalWrongAnswers++;
                              // User selected wrong option
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(
                                    'Wrong Answer!',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'openDyslexic'),
                                  ),
                                  content: Image.asset(
                                    "images/tomwrong.gif",
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                              );
                              playSound("audio/wrong.mp3");
                            }
                          },
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    totalQuestionsAttempted++;
                    setState(() {
                      generateMonkeyCount();
                    });
                  },
                  child: Text('Refresh'),
                ),
              ],
            ),
          ),
        ],
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

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
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
