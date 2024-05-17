import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TamilLetterArrange extends StatefulWidget {
  @override
  _TamilLetterArrangeState createState() => _TamilLetterArrangeState();
}

class _TamilLetterArrangeState extends State<TamilLetterArrange> {
  final AudioPlayer player = AudioPlayer();
  List<String> words = [];
  List<String> jumbledWord = [];
  String currentWord = '';
  String userAnswer = '';
  bool isCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    generateWords();
    getRandomWord();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void generateWords() {
    words = [
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
      'மண்',
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
    ];
  }

  void getRandomWord() {
    Random random = Random();
    int index = random.nextInt(words.length);
    setState(() {
      currentWord = words[index];
      jumbledWord = _jumbleWord(currentWord.split(''));
      isCorrectAnswer = false;
    });
  }

  List<String> _jumbleWord(List<String> word) {
    List<String> jumbled = List.from(word);
    jumbled.shuffle();
    return jumbled;
  }

  void checkAnswer() {
    setState(() {
      isCorrectAnswer = userAnswer == currentWord;
    });
    if (isCorrectAnswer) {
      playSound("audio/correct.mp3");
    } else {
      playSound("audio/wrong.mp3");
    }
  }

  void swapLetters(int draggedIndex, int targetIndex) {
    setState(() {
      String temp = jumbledWord[draggedIndex];
      jumbledWord[draggedIndex] = jumbledWord[targetIndex];
      jumbledWord[targetIndex] = temp;
      // Update userAnswer based on the new arrangement
      userAnswer = jumbledWord.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'தமிழ் எழுத்துக்கள் அமையும் விளையாட்டு',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                'சொல்லை கேட்கவும்:',
                style: TextStyle(fontSize: 22, fontFamily: 'Vanavil'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  playSound("audio/${currentWord}.mp3");
                },
                child: Text('பேசு', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'எழுத்துக்களை அமை:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List.generate(jumbledWord.length, (index) {
                  String char = jumbledWord[index];
                  return Draggable<String>(
                    data: char,
                    feedback: Material(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          char,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontFamily:
                                'Vanavil', // Assuming 'Latha' is a Tamil font
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    child: DragTarget<String>(
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            char,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily:
                                  'Latha', // Assuming 'Latha' is a Tamil font
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      onWillAccept: (data) => true,
                      onAccept: (data) {
                        int draggedIndex = jumbledWord.indexOf(data);
                        int targetIndex = jumbledWord.indexOf(char);
                        List<String> temp = List.from(jumbledWord);
                        temp[draggedIndex] = jumbledWord[targetIndex];
                        temp[targetIndex] = jumbledWord[draggedIndex];
                        setState(() {
                          jumbledWord = temp;
                          userAnswer = jumbledWord.join();
                        });
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  checkAnswer();
                  if (isCorrectAnswer) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('சரியான பதில்!'),
                        content: Image.asset(
                          "images/Monkey2.gif",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('தவறான பதில்!'),
                        content: Image.asset(
                          "images/thumbsDown.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  }
                },
                child: Text('சமர்ப்பிக்கவும்',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: getRandomWord,
                child: Text('புதுப்பி', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Image.asset(
                        "images2/${currentWord}.png",
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                },
                child: Text('உத்திக்கு', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
