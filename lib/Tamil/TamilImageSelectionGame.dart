import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TamilImageSelectionGame extends StatefulWidget {
  @override
  _WordMatchingGameState createState() => _WordMatchingGameState();
}

class _WordMatchingGameState extends State<TamilImageSelectionGame> {
  final AudioPlayer player = AudioPlayer();
  List<String> words = [
    'சிங்கம்',
    'குரங்கு',
    'சங்கு',
    'கங்காரு',
    'சதுரங்கம்',
    'நுங்கு',
    'பொங்கல்',
    'மாங்காய்',
    'பழங்கள்',
    'மூங்கில்',
    'ஒட்டகச்சிவிங்கி',
    'எலுமிச்சை',
    'நீர்வீழ்ச்சி',
    'பெருச்சாளி',
    'நீச்சல்',
    'வண்ணத்துப்பூச்சி',
    'மொச்சை',
    'அச்சாணி',
    'குச்சி',
    'ஈச்சமரம்',
    'பச்சை',
    'தச்சர்',
    'பச்சோந்தி',
    'ஊஞ்சல்',
    'பஞ்ச வர்ணகிளி',
    'பஞ்சு மெத்தை',
    'இஞ்சி',
    'அஞ்சல் பெட்டி',
    'பட்டம்',
    'பட்டாசு',
    'மட்டை',
    'முட்டை',
    'வட்டம்',
    'சட்டை',
    'எட்டு',
    'நண்டு',
    'வண்டு',
    'பூண்டு',
    'கண்',
    'கரண்டி',
    'கண்ணாடி',
    'உண்டியல்',
    'வெண்ணெய்',
    'கத்தி',
    'முத்து',
    'வாத்து',
    'சுத்தி',
    'நத்தை',
    'பத்து',
    'மத்து',
    'பருத்தி',
    'புத்தகம்',
    'கத்தரிக்காய்',
    'மீன்கொத்தி',
    'சிறுத்தை',
    'கொத்தமல்லி'
    // Add more words here...
  ];
  List<String> images = [
    'சிங்கம்.png',
    'குரங்கு.png',
    'சங்கு.png',
    'கங்காரு.png',
    'சதுரங்கம்.png',
    'நுங்கு.png',
    'பொங்கல்.png',
    'மாங்காய்.png',
    'பழங்கள்.png',
    'மூங்கில்.png',
    'ஒட்டகச்சிவிங்கி.png',
    'எலுமிச்சை.png',
    'நீர்வீழ்ச்சி.png',
    'பெருச்சாளி.png',
    'நீச்சல்.png',
    'வண்ணத்துப்பூச்சி.png',
    'மொச்சை.png',
    'அச்சாணி.png',
    'குச்சி.png',
    'ஈச்சமரம்.png',
    'பச்சை.png',
    'தச்சர்.png',
    'பச்சோந்தி.png',
    'ஊஞ்சல்.png',
    'பஞ்ச வர்ணகிளி.png',
    'பஞ்சு மெத்தை.png',
    'இஞ்சி.png',
    'அஞ்சல் பெட்டி.png',
    'பட்டம்.png',
    'பட்டாசு.png',
    'மட்டை.png',
    'முட்டை.png',
    'வட்டம்.png',
    'சட்டை.png',
    'எட்டு.png',
    'நண்டு.png',
    'வண்டு.png',
    'பூண்டு.png',
    'கண்.png',
    'கரண்டி.png',
    'கண்ணாடி.png',
    'உண்டியல்.png',
    'வெண்ணெய்.png',
    'கத்தி.png',
    'முத்து.png',
    'வாத்து.png',
    'சுத்தி.png',
    'நத்தை.png',
    'பத்து.png',
    'மத்து.png',
    'பருத்தி.png',
    'புத்தகம்.png',
    'கத்தரிக்காய்.png',
    'மீன்கொத்தி.png',
    'சிறுத்தை.png',
    'கொத்தமல்லி.png'

    // Add corresponding image paths here...
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
        title: Text('படம் கண்டு சொல் ',
            style: TextStyle(
                fontFamily: 'openDyslexic',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
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
                    Text(
                      selectedWord.toUpperCase(),
                      style: TextStyle(
                          fontSize: 24,
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
                            margin: EdgeInsets.all(8),
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _setNextQuestion();
                      },
                      child: Text('புதுப்பி'),
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
