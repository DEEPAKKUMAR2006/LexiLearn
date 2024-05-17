import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_tts/flutter_tts.dart';

class RhymeTimeGame extends StatefulWidget {
  @override
  _RhymeTimeGameState createState() => _RhymeTimeGameState();
}

class _RhymeTimeGameState extends State<RhymeTimeGame> {
  final AudioPlayer player = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  List<String> words = [
    'king', 'ring', 'table', 'cable', 'blossom', 'awesome', 'broom', 'groom',
    'car',
    'jar',
    'star',
    'spar',
    'moon',
    'soon',
    'book',
    'hook',
    'tree',
    'free',
    'light',
    'might',
    'kite',
    'bite',
    'cat',
    'hat',
    'dog',
    'log',
    'fish',
    'wish',
    'heart',
    'start',
    'hand',
    'land',
    'bell',
    'well',
    'duck',
    'luck',
    'road',
    'toad',
    'dance',
    'chance',
    'glove',
    'love',
    'key',
    'bee',
    'pen',
    'hen',
    'shoe',
    'blue',
    'hair',
    'bear',
    'song',
    'long',
    'cup',
    'pup',
    'ship',
    'flip',
    'smile', 'while',
    'game', 'flame',
    'clock', 'rock',
    'flower', 'power',
    'frog', 'log',
    'chair', 'mare',
    'crown', 'frown',
    'drum', 'hum',
    'fire', 'wire',
    'gate', 'late',
    'glove', 'above',
    'glass', 'mass',
    'mouse', 'house',
    'hat', 'bat',
    'train', 'rain',
    'leaf', 'beef',
    'sock', 'block',
    'night', 'kite',
    'pond', 'bond',
    'spoon', 'moon',
    'snake', 'make',
    'beach', 'peach',
    'road', 'load',
    'king', 'wing',
    'chair', 'mare',
    'ball', 'mall',
    'light', 'fight',
    'board', 'chord',
    'chalk', 'talk',
    'floor', 'door',
    'hand', 'stand'

    // Add more words here...
  ];
  Map<String, String> rhymePairs = {
    'king': 'ring',
    'ring': 'king',
    'table': 'cable',
    'cable': 'table',
    'blossom': 'awesome',
    'awesome': 'blossom',
    'broom': 'groom',
    'groom': 'broom',
    'car': 'jar',
    'star': 'spar',
    'moon': 'soon',
    'book': 'hook',
    'tree': 'free',
    'light': 'might',
    'kite': 'bite',
    'cat': 'hat',
    'dog': 'log',
    'fish': 'wish',
    'heart': 'start',
    'hand': 'land',
    'bell': 'well',
    'duck': 'luck',
    'road': 'toad',
    'dance': 'chance',
    'glove': 'love',
    'key': 'bee',
    'pen': 'hen',
    'shoe': 'blue',
    'hair': 'bear',
    'song': 'long',
    'cup': 'pup',
    'ship': 'flip',
    'smile': 'while',
    'game': 'flame',
    'clock': 'rock',
    'flower': 'power',
    'frog': 'log',
    'chair': 'mare',
    'crown': 'frown',
    'drum': 'hum',
    'fire': 'wire',
    'gate': 'late',
    'glove': 'above',
    'glass': 'mass',
    'mouse': 'house',
    'hat': 'bat',
    'train': 'rain',
    'leaf': 'beef',
    'sock': 'block',
    'night': 'kite',
    'pond': 'bond',
    'spoon': 'moon',
    'snake': 'make',
    'beach': 'peach',
    'road': 'load',
    'king': 'wing',
    'mare': 'chair',
    'mall': 'ball',
    'fight': 'light',
    'chord': 'board',
    'talk': 'chalk',
    'door': 'floor',
    'stand': 'hand',
    'jar': 'car',
    'spar': 'star',
    'soon': 'moon',
    'hook': 'book',
    'free': 'tree',
    'might': 'light',
    'bite': 'kite',
    'hat': 'cat',
    'log': 'dog',
    'wish': 'fish',
    'start': 'heart',
    'land': 'hand',
    'well': 'bell',
    'luck': 'duck',
    'toad': 'road',
    'chance': 'dance',
    'love': 'glove',
    'bee': 'key',
    'hen': 'pen',
    'blue': 'shoe',
    'bear': 'hair',
    'long': 'song',
    'pup': 'cup',
    'flip': 'ship',
    'while': 'smile',
    'flame': 'game',
    'rock': 'clock',
    'power': 'flower',
    'log': 'frog',
    'mare': 'chair',
    'frown': 'crown',
    'hum': 'drum',
    'wire': 'fire',
    'late': 'gate',
    'above': 'glove',
    'mass': 'glass',
    'house': 'mouse',
    'bat': 'hat',
    'rain': 'train',
    'beef': 'leaf',
    'block': 'sock',
    'kite': 'night',
    'bond': 'pond',
    'moon': 'spoon',
    'make': 'snake',
    'peach': 'beach',
    'load': 'road',
    'wing': 'king',
    'chair': 'mare',
    'ball': 'mall',
    'light': 'fight',
    'board': 'chord',
    'chalk': 'talk',
    'floor': 'door',
    'hand': 'stand'

    // Add more pairs here...
  };
  String selectedWord = '';
  String correctOption = '';
  List<String> rhymeOptions = [];
  bool isCorrect = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;
  bool isVolumeEnabled = true;

  @override
  void initState() {
    super.initState();
    _setNextQuestion();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  Future<void> _speak(String word) async {
    await flutterTts.setSpeechRate(0.2);
    await flutterTts.speak(word);
  }

  void _setNextQuestion() {
    setState(() {
      selectedWord = words[Random().nextInt(words.length)];
      correctOption = rhymePairs[selectedWord] ?? '';

      // Generate incorrect options
      rhymeOptions = [];
      while (rhymeOptions.length < 3) {
        String randomWord = words[Random().nextInt(words.length)];
        if (randomWord != selectedWord &&
            randomWord != correctOption &&
            !rhymeOptions.contains(randomWord)) {
          rhymeOptions.add(randomWord);
        }
      }

      // Add correct option to the list
      rhymeOptions.add(correctOption);
      rhymeOptions.shuffle();

      isCorrect = false; // Reset correctness flag
    });
  }

  void checkMatch(String word) {
    setState(() {
      totalQuestionsAttempted++;
      isCorrect = word == correctOption;
    });
    if (isCorrect) {
      totalCorrectAnswers++;
      playSound("audio/yay.mp3");
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
      playSound("audio/wrong.mp3");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rhyme Time',
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
                    SizedBox(height: 70),
                    Text(
                      'Select the correct word that rhymes with the below word',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'openDyslexic',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            selectedWord.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'openDyslexic',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            Icons.volume_up,
                            color: isVolumeEnabled ? Colors.black : Colors.grey,
                          ),
                          onPressed: () {
                            if (isVolumeEnabled) _speak(selectedWord);
                          },
                        ),
                      ],
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: List.generate(rhymeOptions.length, (index) {
                        String word = rhymeOptions[index];
                        return GestureDetector(
                          onTap: () {
                            if (!isCorrect) {
                              if (isVolumeEnabled) _speak(word);
                              checkMatch(word);
                            }
                          },
                          child: Column(
                            children: [
                              Container(
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
                                        checkMatch(word);
                                      }
                                    },
                                    child: SizedBox(
                                      width: 150,
                                      height: 80,
                                      child: Center(
                                        child: Text(
                                          word.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'openDyslexic',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up,
                                  color: isVolumeEnabled
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  if (isVolumeEnabled) _speak(word);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
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
