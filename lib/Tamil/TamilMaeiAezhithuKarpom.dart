import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TamilMaeiAezhuthuKarpom(),
    );
  }
}

class TamilMaeiAezhuthuKarpom extends StatefulWidget {
  @override
  _LetterExercisePageState createState() => _LetterExercisePageState();
}

class _LetterExercisePageState extends State<TamilMaeiAezhuthuKarpom> {
  int currentIndex = 0;
  AudioPlayer player = AudioPlayer();

  List<LetterInfo> letterInfoList = [
    LetterInfo(
        letter: 'க்',
        image: 'கொக்கு.jpeg',
        description: 'கொக்கு',
        lettersound: 'audio/க்.mp3',
        descsound: 'audio/கொக்கு.mp3'),
    LetterInfo(
        letter: 'ங்',
        image: 'சிங்கம்.png',
        description: 'ஆடு',
        lettersound: 'audio/ங்.mp3',
        descsound: 'audio/சிங்கம் .mp3'),
    LetterInfo(
        letter: 'ச்',
        image: 'எலுமிச்சை.png',
        description: 'எலுமிச்சை',
        lettersound: 'audio/ச்.mp3',
        descsound: 'audio/எலுமிச்சை.mp3'),
    LetterInfo(
        letter: 'ஞ்',
        image: 'ஊஞ்சல்.png',
        description: 'ஊஞ்சல்',
        lettersound: 'audio/ஞ்.mp3',
        descsound: 'audio/ஊஞ்சல்.mp3'),
    LetterInfo(
        letter: 'ட்	',
        image: 'பட்டம்.png',
        description: 'பட்டம்',
        lettersound: 'audio/ட்.mp3',
        descsound: 'audio/பட்டம்.mp3'),
    LetterInfo(
        letter: 'ண்',
        image: 'கண்ணாடி.png',
        description: 'கண்ணாடி',
        lettersound: 'audio/ண்.mp3',
        descsound: 'audio/கண்ணாடி.mp3'),
    LetterInfo(
        letter: 'த்',
        image: 'பத்து.png',
        description: 'பத்து',
        lettersound: 'audio/த்.mp3',
        descsound: 'audio/பத்து.mp3'),
    LetterInfo(
        letter: 'ந்',
        image: 'பந்து.png',
        description: 'பந்து',
        lettersound: 'audio/ந்.mp3',
        descsound: 'audio/பந்து.mp3'),
    LetterInfo(
        letter: 'ப்',
        image: 'பலாப்பழம்.png',
        description: 'பலாப்பழம்',
        lettersound: 'audio/ப்.mp3',
        descsound: 'audio/பலாப்பழம்.mp3'),
    LetterInfo(
        letter: 'ம்',
        image: 'காகம்.png',
        description: 'காகம்',
        lettersound: 'audio/ம்.mp3',
        descsound: 'audio/காகம்.mp3'),
    LetterInfo(
        letter: 'ய்',
        image: 'மாங்காய்.png',
        description: 'மாங்காய்',
        lettersound: 'audio/ய்.mp3',
        descsound: 'audio/மாங்காய்.mp3'),
    LetterInfo(
        letter: 'ர்',
        image: 'இளநீர்.png',
        description: 'இளநீர்',
        lettersound: 'audio/ர்.mp3',
        descsound: 'audio/இளநீர்.mp3'),
    LetterInfo(
        letter: 'ல்',
        image: 'முயல்.png',
        description: 'முயல்',
        lettersound: 'audio/ல்.mp3',
        descsound: 'audio/முயல்.mp3'),
    LetterInfo(
        letter: 'வ்',
        image: 'செவ்வகம்.png',
        description: 'செவ்வகம்',
        lettersound: 'audio/வ்.mp3',
        descsound: 'audio/செவ்வகம்.mp3'),
    LetterInfo(
        letter: 'ழ்',
        image: 'நீர்வீழ்ச்சி.png',
        description: 'நீர்வீழ்ச்சி',
        lettersound: 'audio/ழ்.mp3',
        descsound: 'audio/நீர்வீழ்ச்சி.mp3'),
    LetterInfo(
        letter: 'ள்',
        image: 'புள்ளிமான்.png',
        description: 'புள்ளிமான்',
        lettersound: 'audio/ள்.mp3',
        descsound: 'audio/புள்ளிமான்.mp3'),
    LetterInfo(
        letter: 'ற்',
        image: 'நாற்காலி.png',
        description: 'நாற்காலி',
        lettersound: 'audio/ற்.mp3',
        descsound: 'audio/நாற்காலி.mp3'),
    LetterInfo(
        letter: 'ன்',
        image: 'மூன்று.jpeg',
        description: 'மூன்று',
        lettersound: 'audio/ன்.mp3',
        descsound: 'audio/மூன்று.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('மெய்யெழுத்து கற்போம்',
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
