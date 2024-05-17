import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_tts/flutter_tts.dart';

class RhymeTimeGameTamil extends StatefulWidget {
  @override
  _RhymeTimeGameState createState() => _RhymeTimeGameState();
}

class _RhymeTimeGameState extends State<RhymeTimeGameTamil> {
  final AudioPlayer player = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  List<String> words = [
    'வீடு', 'பூடு',
    'அழகு', 'பழகு',
    'மலை', 'கலை',
    'சூரியன்', 'பூரியன்',
    'கடல்', 'மணல்',
    'வண்டி', 'பண்டி',
    'பார்வை', 'வார்வை',
    'பாடல்', 'நாடல்',
    'வேலை', 'சேலை',
    'நாவல்', 'மோவல்',
    'மழை', 'வாழை',
    'நெஞ்சம்', 'பெஞ்சம்',
    'பாதம்', 'வாதம்',
    'பழம்', 'செழம்',
    'பல்', 'தல்',
    'வெண்கலம்', 'கண்கலம்',
    'வீசு', 'மீசு',
    'புல்', 'குல்',
    'பூச்சி', 'பட்சி',
    'மீன்', 'கீன்',
    'மொழி', 'நொழி',
    'நாரி', 'காரி',
    'நிலா', 'கிளா',
    'மூங்கில்', 'வூங்கில்',
    'நாள்', 'காள்',
    'நாதன்', 'மாதன்',
    'மூன்று', 'சூன்று',
    'குண்டு', 'வுண்டு',
    'தொலை', 'சொலை',
    'நம்பிக்கை', 'பாம்பிக்கை',
    'கண்', 'பண்',
    'பாட்டி', 'பண்டி',
    'படி', 'பணி',
    'செம்மொழி', 'பெம்மொழி',
    'நெஞ்சம்', 'கெஞ்சம்',
    'பூண்டு', 'தூண்டு',
    'சூடு', 'கூடு',
    'முட்டு', 'சுட்டு',
    'அரசன்', 'சரசன்',
    'பழம்', 'வழம்',
    'கல்லு', 'வல்லு',
    'வயல்', 'கையல்',
    'நல்லவன்', 'வல்லவன்',
    'சாதனை', 'பாதனை',
    'நாட்டு', 'வாட்டு',
    'நகரம்', 'நாகரம்',
    'கரும்பு', 'மரும்பு',
    'பெரும்பால்', 'பல்லாபால்',
    'அடுப்பு', 'படுப்பு',
    'கொடுமை', 'மடுமை',
    'அடி', 'நடி',
    'காண', 'பாண',
    'கண்', 'நண்',
    'மண்', 'தண்',
    'பல்', 'கல்',
    'முன்', 'பின்',
    'பணி', 'கணி',
    'கரி', 'மரி',
    'அருமை', 'பருமை',
    'கால்', 'மால்',
    'கவலை', 'சொலை'
    // Add more words here...
  ];
  Map<String, String> rhymePairs = {
    'பூடு': 'வீடு',
    'பழகு': 'அழகு',
    'கலை': 'மலை',
    'பூரியன்': 'சூரியன்',
    'மணல்': 'கடல்',
    'பண்டி': 'வண்டி',
    'வார்வை': 'பார்வை',
    'நாடல்': 'பாடல்',
    'சேலை': 'வேலை',
    'மோவல்': 'நாவல்',
    'வாழை': 'மழை',
    'பெஞ்சம்': 'நெஞ்சம்',
    'வாதம்': 'பாதம்',
    'செழம்': 'பழம்',
    'தல்': 'பல்',
    'கண்கலம்': 'வெண்கலம்',
    'மீசு': 'வீசு',
    'குல்': 'புல்',
    'பட்சி': 'பூச்சி',
    'கீன்': 'மீன்',
    'நொழி': 'மொழி',
    'காரி': 'நாரி',
    'கிளா': 'நிலா',
    'வூங்கில்': 'மூங்கில்',
    'காள்': 'நாள்',
    'மாதன்': 'நாதன்',
    'சூன்று': 'மூன்று',
    'வுண்டு': 'குண்டு',
    'சொலை': 'தொலை',
    'பாம்பிக்கை': 'நம்பிக்கை',
    'பண்': 'கண்',
    'பண்டி': 'பாட்டி',
    'பணி': 'படி',
    'பெம்மொழி': 'செம்மொழி',
    'கெஞ்சம்': 'நெஞ்சம்',
    'தூண்டு': 'பூண்டு',
    'கூடு': 'சூடு',
    'சுட்டு': 'முட்டு',
    'சரசன்': 'அரசன்',
    'வழம்': 'பழம்',
    'வல்லு': 'கல்லு',
    'கையல்': 'வயல்',
    'வல்லவன்': 'நல்லவன்',
    'பாதனை': 'சாதனை',
    'வாட்டு': 'நாட்டு',
    'நாகரம்': 'நகரம்',
    'மரும்பு': 'கரும்பு',
    'பல்லாபால்': 'பெரும்பால்',
    'படுப்பு': 'அடுப்பு',
    'மடுமை': 'கொடுமை',
    'நடி': 'அடி',
    'பாண': 'காண',
    'நண்': 'கண்',
    'தண்': 'மண்',
    'கல்': 'பல்',
    'பின்': 'முன்',
    'கணி': 'பணி',
    'மரி': 'கரி',
    'பருமை': 'அருமை',
    'மால்': 'கால்',
    'சொலை': 'கவலை',
    'வீடு': 'பூடு',
    'அழகு': 'பழகு',
    'மலை': 'கலை',
    'சூரியன்': 'பூரியன்',
    'கடல்': 'மணல்',
    'வண்டி': 'பண்டி',
    'பார்வை': 'வார்வை',
    'பாடல்': 'நாடல்',
    'வேலை': 'சேலை',
    'நாவல்': 'மோவல்',
    'மழை': 'வாழை',
    'நெஞ்சம்': 'பெஞ்சம்',
    'பாதம்': 'வாதம்',
    'பழம்': 'செழம்',
    'பல்': 'தல்',
    'வெண்கலம்': 'கண்கலம்',
    'வீசு': 'மீசு',
    'புல்': 'குல்',
    'பூச்சி': 'பட்சி',
    'மீன்': 'கீன்',
    'மொழி': 'நொழி',
    'நாரி': 'காரி',
    'நிலா': 'கிளா',
    'மூங்கில்': 'வூங்கில்',
    'நாள்': 'காள்',
    'நாதன்': 'மாதன்',
    'மூன்று': 'சூன்று',
    'குண்டு': 'வுண்டு',
    'தொலை': 'சொலை',
    'நம்பிக்கை': 'பாம்பிக்கை',
    'கண்': 'பண்',
    'பாட்டி': 'பண்டி',
    'படி': 'பணி',
    'செம்மொழி': 'பெம்மொழி',
    'நெஞ்சம்': 'கெஞ்சம்',
    'பூண்டு': 'தூண்டு',
    'சூடு': 'கூடு',
    'முட்டு': 'சுட்டு',
    'அரசன்': 'சரசன்',
    'பழம்': 'வழம்',
    'கல்லு': 'வல்லு',
    'வயல்': 'கையல்',
    'நல்லவன்': 'வல்லவன்',
    'சாதனை': 'பாதனை',
    'நாட்டு': 'வாட்டு',
    'நகரம்': 'நாகரம்',
    'கரும்பு': 'மரும்பு',
    'பெரும்பால்': 'பல்லாபால்',
    'அடுப்பு': 'படுப்பு',
    'கொடுமை': 'மடுமை',
    'அடி': 'நடி',
    'காண': 'பாண',
    'கண்': 'நண்',
    'மண்': 'தண்',
    'பல்': 'கல்',
    'முன்': 'பின்',
    'பணி': 'கணி',
    'கரி': 'மரி',
    'அருமை': 'பருமை',
    'கால்': 'மால்',
    'கவலை': 'சொலை'

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
    flutterTts.setLanguage("ta-In");
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
        title: Text('தமிழ் பாசுரம்',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
                      'கீழே உள்ள வார்த்தையுடன் ரைம் செய்யும் சரியான வார்த்தையைத் தேர்ந்தெடுக்கவும்',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'openDyslexic',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
