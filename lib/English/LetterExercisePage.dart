import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ExercisePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LetterExercisePage(),
    );
  }
}

class LetterExercisePage extends StatefulWidget {
  @override
  _LetterExercisePageState createState() => _LetterExercisePageState();
}

class _LetterExercisePageState extends State<LetterExercisePage> {
  int currentIndex = 0;
  FlutterTts flutterTts = FlutterTts();

  List<LetterInfo> letterInfoList = [
    LetterInfo(
        letter: 'A', smallLetter: 'a', image: 'A.jpg', description: 'Apple'),
    LetterInfo(
        letter: 'B', smallLetter: 'b', image: 'B.jpg', description: 'Ball'),
    LetterInfo(
        letter: 'C', smallLetter: 'c', image: 'C.jpg', description: 'Cat'),
    LetterInfo(
        letter: 'D', smallLetter: 'd', image: 'D.jfif', description: 'Dog'),
    LetterInfo(
        letter: 'E', smallLetter: 'e', image: 'E.jpg', description: 'Elephant'),
    LetterInfo(
        letter: 'F', smallLetter: 'f', image: 'F.png', description: 'Fish'),
    LetterInfo(
        letter: 'G', smallLetter: 'g', image: 'G.jpg', description: 'Glass'),
    LetterInfo(
        letter: 'H', smallLetter: 'h', image: 'H.jpg', description: 'Hand'),
    LetterInfo(
        letter: 'I', smallLetter: 'i', image: 'I.jpg', description: 'Icecream'),
    LetterInfo(
        letter: 'J', smallLetter: 'j', image: 'J.jpg', description: 'Jam'),
    LetterInfo(
        letter: 'K', smallLetter: 'k', image: 'K.jpg', description: 'Key'),
    LetterInfo(
        letter: 'L', smallLetter: 'l', image: 'L.jfif', description: 'Laptop'),
    LetterInfo(
        letter: 'M', smallLetter: 'm', image: 'M.jpg', description: 'Monkey'),
    LetterInfo(
        letter: 'N', smallLetter: 'n', image: 'N.jpg', description: 'Notebook'),
    LetterInfo(
        letter: 'O', smallLetter: 'o', image: 'O.jpg', description: 'Orange'),
    LetterInfo(
        letter: 'P', smallLetter: 'p', image: 'P.png', description: 'Pencil'),
    LetterInfo(
        letter: 'Q', smallLetter: 'q', image: 'Q.jpg', description: 'Queen'),
    LetterInfo(
        letter: 'R', smallLetter: 'r', image: 'R.jpg', description: 'Rice'),
    LetterInfo(
        letter: 'S', smallLetter: 's', image: 'S.jpg', description: 'Spoon'),
    LetterInfo(
        letter: 'T', smallLetter: 't', image: 'T.jpg', description: 'Tiger'),
    LetterInfo(
        letter: 'U', smallLetter: 'u', image: 'U.jpg', description: 'Umbrella'),
    LetterInfo(
        letter: 'V',
        smallLetter: 'v',
        image: 'V.jpg',
        description: 'Vegetables'),
    LetterInfo(
        letter: 'W', smallLetter: 'w', image: 'W.jpg', description: 'Water'),
    LetterInfo(
        letter: 'X', smallLetter: 'x', image: 'X.jpg', description: 'Xerox'),
    LetterInfo(
        letter: 'Y', smallLetter: 'y', image: 'Y.jpg', description: 'Yoga'),
    LetterInfo(
        letter: 'Z', smallLetter: 'z', image: 'Z.jpg', description: 'Zebra')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Learn Alphabets',
          style: TextStyle(fontFamily: 'openDyslexic'),
        ),
      ),
      body: PageView.builder(
        itemCount: letterInfoList.length,
        controller: PageController(initialPage: currentIndex),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                  fontFamily: 'openDyslexic',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                letterInfoList[index].smallLetter,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        style: GoogleFonts.aBeeZee(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          speakLetter(letterInfoList[index].letter);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('Listen Letter',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          speakDescription(letterInfoList[index].description);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('Listen Description',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExercisePage(
                                selectedLetter: letterInfoList[index].letter,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('Exercise',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> speakLetter(String letter) async {
    await flutterTts.setSpeechRate(0.2);
    await flutterTts.speak(letter);
  }

  Future<void> speakDescription(String description) async {
    await flutterTts.setSpeechRate(0.2);
    await flutterTts.speak(description);
  }
}

class LetterInfo {
  final String letter;
  final String smallLetter;
  final String image;
  final String description;

  LetterInfo({
    required this.letter,
    required this.smallLetter,
    required this.image,
    required this.description,
  });
}
