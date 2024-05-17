import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LetterExercisePage2(),
    );
  }
}

class LetterExercisePage2 extends StatefulWidget {
  @override
  _LetterExercisePageState createState() => _LetterExercisePageState();
}

class _LetterExercisePageState extends State<LetterExercisePage2> {
  int currentIndex = 0;
  AudioPlayer player = AudioPlayer();

  List<LetterInfo> letterInfoList = [
    LetterInfo(
        letter: 'அ',
        image: 'அம்மா.png',
        description: 'அம்மா',
        lettersound: 'audio/அ.mp3',
        descsound: 'audio/அம்மா.mp3'),
    LetterInfo(
        letter: 'ஆ',
        image: 'ஆடு.png',
        description: 'ஆடு',
        lettersound: 'audio/ஆ.mp3',
        descsound: 'audio/ஆடு.mp3'),
    LetterInfo(
        letter: 'இ',
        image: 'இலை.jpg',
        description: 'இலை',
        lettersound: 'audio/இ.mp3',
        descsound: 'audio/இலை.mp3'),
    LetterInfo(
        letter: 'ஈ',
        image: 'ஈசல்.jpg',
        description: 'ஈசல்',
        lettersound: 'audio/ஈ.mp3',
        descsound: 'audio/ஈசல்.mp3'),
    LetterInfo(
        letter: 'உ',
        image: 'உரல்.jpg',
        description: 'உரல்',
        lettersound: 'audio/உ.mp3',
        descsound: 'audio/உரல்.mp3'),
    LetterInfo(
        letter: 'ஊ',
        image: 'ஊஞ்சல்.jpg',
        description: 'ஊஞ்சல்',
        lettersound: 'audio/ஊ.mp3',
        descsound: 'audio/ஊஞ்சல்.mp3'),
    LetterInfo(
        letter: 'எ',
        image: 'எறும்பு.jpg',
        description: 'எறும்பு',
        lettersound: 'audio/எ.mp3',
        descsound: 'audio/எறும்பு.mp3'),
    LetterInfo(
        letter: 'ஏ',
        image: 'ஏணி.jpg',
        description: 'ஏணி',
        lettersound: 'audio/ஏ.mp3',
        descsound: 'audio/ஏணி.mp3'),
    LetterInfo(
        letter: 'ஐ',
        image: 'ஐவர்.png',
        description: 'ஐவர்',
        lettersound: 'audio/ஐ.mp3',
        descsound: 'audio/ஐவர்.mp3'),
    LetterInfo(
        letter: 'ஒ',
        image: 'ஒட்டகம்.jpg',
        description: 'ஒட்டகம்',
        lettersound: 'audio/ஒ.mp3',
        descsound: 'audio/ஒட்டகம்.mp3'),
    LetterInfo(
        letter: 'ஓ',
        image: 'ஓணான்.jpg',
        description: 'ஓணான்',
        lettersound: 'audio/ஓ.mp3',
        descsound: 'audio/ஓணான்.mp3'),
    LetterInfo(
        letter: 'ஔ',
        image: 'ஔவையார்.jpg',
        description: 'ஔவையார்',
        lettersound: 'audio/ஔ.mp3',
        descsound: 'audio/ஔவையார்.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('உயிரெழுத்து கற்போம்',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
          ),
          PageView.builder(
            itemCount: letterInfoList.length,
            controller: PageController(initialPage: currentIndex),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          letterInfoList[index].letter,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'images/${letterInfoList[index].image}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      letterInfoList[index].description,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        playSound(letterInfoList[index].lettersound);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'எழுத்து கேட்க',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        playSound(letterInfoList[index].descsound);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'விளக்கத்தை கேட்க',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }
}

class LetterInfo {
  final String letter;
  final String image;
  final String description;
  final String lettersound;
  final String descsound;

  LetterInfo(
      {required this.letter,
      required this.image,
      required this.description,
      required this.lettersound,
      required this.descsound});
}
