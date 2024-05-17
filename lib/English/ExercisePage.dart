import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExercisePage extends StatefulWidget {
  final String selectedLetter;

  ExercisePage({required this.selectedLetter});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<String> words = [];
  FlutterTts flutterTts = FlutterTts();
  Map<int, Color> buttonColors = {};
  final player = AudioPlayer();
  bool showCorrectImage = false;
  bool showWrongImage = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;
  List<bool> wordAnswered = [false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    generateWords();
    initializeButtonColors();
  }

  void generateWords() {
    Map<String, List<String>> wordMap = {
      'A': [
        'Apple',
        'glAss',
        'glAss',
        'flAme',
        'branch',
        'brave',
        'plate',
        'sharp',
        'calm',
        'hang',
        'share',
        'race',
        'giant',
        'tail',
        'half',
        'track',
        'rally',
        'snail',
        'back',
        'grade',
        'grass',
        'nail',
        'jam',
        'add',
        'land',
        'mad',
        'stamp',
        'mast',
        'stain',
        'lake',
        'page',
        'male',
        'shake',
        'pal',
        'fast',
        'bake',
        'waste',
        'game',
        'tape',
        'cage',
        'fame',
        'lace',
        'drain',
        'gap',
        'cake',
        'praise',
        'sample',
        'parade',
        'pace',
        'mate',
        'fade',
        'sail',
        'late',
        'cast',
        'flag',
        'share',
        'madam',
        'camera',
        'fragile',
        'alarm',
        'tale',
        'flame',
        'trail',
        'place',
        'abate',
        'claim',
        'gaze',
        'awake',
        'flair',
        'glad',
        'splash',
        'tangle',
        'jar',
        'marble',
        'drama',
        'table',
        'crane',
        'faint',
        'bland',
        'label',
        'daze',
        'barge',
        'blame',
        'lame',
        'rag',
        'whale',
        // Add your words here
      ],
      'B': [
        'ball',
        'bake',
        'bold',
        'bump',
        'bull',
        'bank',
        'band',
        'bolt',
        'bilk',
        'bane',
        'beach',
        'blank',
        'brave',
        'begin',
        'burst',
        'blend',
        'block',
        'bread',
        'bright',
        'budget',
        'burden',
        'breeze',
        'border',
        'button',
        'branch',
        'backup',
        'brisk',
        'blast',
        'brawl',
        'buddy',
        'amber',
        'limbo',
        'turbo',
        'embed',
        'ember',
        'nimby',
        'combo',
        'tombs',
        'umbra',
        'umber',
        'adverb',
        'cherub',
        'confab',
        'superb',
        'reverb',
        'enwomb'
      ],
      'C': [
        'cake',
        'cape',
        'chug',
        'chin',
        'chef',
        'cane',
        'chop',
        'code',
        'cord',
        'call',
        'vicar',
        'recur',
        'socle',
        'picot',
        'paced',
        'duces',
        'decaf',
        'mucin',
        'niece',
        'acute',
        'public',
        'panic',
        'attic',
        'relic',
        'gothic',
        'clinic',
        'biotic',
        'mimic',
        'ethnic',
        'exotic',
        'frolic'
      ],
      'D': [
        'Dusk',
        'Dive',
        'Dank',
        'Doll',
        'Dome',
        'Damp',
        'Disk',
        'Deck',
        'Duel',
        'Duct',
        'Adept',
        'Media',
        'Laden',
        'Ridge',
        'Model',
        'Fade',
        'Cider',
        'Ideal',
        'Adore',
        'Absurd',
        'Braced',
        'Flawed',
        'Graced',
        'Hosted',
        'Joined',
        'Quoted',
        'Risked',
        'Shade',
        'Yielded'
      ],
      'E': [
        'Each',
        'Ends',
        'Envy',
        'Edgy',
        'Exam',
        'Echo',
        'Exit',
        'Ears',
        'Emit',
        'Evil',
        'Dress',
        'Bread',
        'Trend',
        'Dream',
        'Great',
        'Blend',
        'Amend',
        'Arena',
        'Ahead',
        'Dread',
        'Puzzle',
        'Circle',
        'Handle',
        'Muscle',
        'Bottle',
        'Castle',
        'Bubble',
        'Candle',
        'Female',
        'Riddle'
      ],
      'F': [
        'Roof',
        'Fit',
        'Fix',
        'Fan',
        'Fed',
        'Fig',
        'Fin',
        'For',
        'Fly',
        'Fox',
        'Fun',
        'Fur',
        'Fee',
        'Foe',
        'Fad',
        'Fog',
        'Fax',
        'Few',
        'Fay',
        'Fob',
        'Far',
        'Beef',
        'Cuff',
        'Leaf',
        'Beef',
        'Chef',
        'Calf',
        'Loaf',
        'Golf',
        'Self',
        'Wolf',
        'Brief',
        'Shelf',
        'Chief',
        'Dwarf',
        'Proof',
        'Stuff',
        'Brief',
      ],
      'G': [
        'Gap',
        'Gas',
        'Get',
        'Gun',
        'Gum',
        'Got',
        'God',
        'Gin',
        'Get',
        'Gal',
        'Logo',
        'Pogo',
        'Range',
        'Image',
        'Badge',
        'Doing',
        'Being',
        'Using',
        'Ruing',
        'Lying'
      ],
      'H': [
        'Hat',
        'Hem',
        'Her',
        'Him',
        'His',
        'How',
        'Hub',
        'Hum',
        'Hug',
        'Hay',
        'chat',
        'chew',
        'chef',
        'chip',
        'ache',
        'Truth',
        'Cloth',
        'Death',
        'Faith',
        'Fresh'
      ],
      'I': [
        'Ice',
        'Ink',
        'Inn',
        'Ion',
        'Ivy',
        'Ire',
        'Imp',
        'Icy',
        'Iff',
        'Ick',
        'Bike',
        'Site',
        'Hide',
        'Time',
        'Fine',
        'Fungi',
        'Cacti',
        'dhoti',
        'zombi',
        'multi'
      ],
      'J': [
        'Job',
        'Jog',
        'Jot',
        'Joy',
        'Jug',
        'Jam',
        'Jar',
        'Jaw',
        'Jet',
        'Jab',
        'Ajee',
        'Bija',
        'Haji',
        'Juju',
        'Mojo',
        'kilij',
        'samaj',
        'aflaj',
        'basij',
        'falaj'
      ],
      'K': [
        'Key',
        'Kid',
        'Kit',
        'Kin',
        'Ken',
        'Keg',
        'Kip',
        'Koi',
        'Kye',
        'Kex',
        'Lake',
        'Like',
        'Poke',
        'Joke',
        'Bike',
        'Quick',
        'Brick',
        'Stick',
        'Track',
        'Black'
      ],
      'L': [
        'Lab',
        'Lad',
        'Lag',
        'Lap',
        'Law',
        'Lay',
        'Led',
        'Leg',
        'Let',
        'Lid',
        'Pale',
        'Tile',
        'Hole',
        'Pole',
        'Tale',
        'Angel',
        'Pixel',
        'Rebel',
        'Wheel',
        'Jewel'
      ],
      'M': [
        'Mad',
        'Man',
        'Map',
        'Mat',
        'May',
        'Met',
        'Mix',
        'Mob',
        'Mod',
        'Mom',
        'Some',
        'Fame',
        'Dome',
        'Time',
        'Come',
        'Alarm',
        'Prism',
        'Realm',
        'Dream',
        'Cream'
      ],
      'N': [
        'Nap',
        'Net',
        'Nib',
        'Nil',
        'Nip',
        'Nit',
        'Nod',
        'Nor',
        'Now',
        'Nut',
        'Bone',
        'Cane',
        'Fine',
        'Lone',
        'Pine',
        'Lemon',
        'Token',
        'Raven',
        'Queen',
        'Ocean'
      ],
      'O': [
        'Oil',
        'Old',
        'One',
        'Opt',
        'Ore',
        'Our',
        'Out',
        'Owl',
        'Own',
        'Oak',
        'Bore',
        'Core',
        'Fore',
        'More',
        'Sore',
        'Audio',
        'Piano',
        'Radio',
        'Video',
        'Mango'
      ],
      'P': [
        'Pie',
        'Pig',
        'Pin',
        'Peg',
        'Pen',
        'Pat',
        'Paw',
        'Pad',
        'Pal',
        'Pan',
        'Wipe',
        'Hope',
        'Rope',
        'Tape',
        'Type',
        'Stump',
        'Equip',
        'Clamp',
        'Grasp',
        'Creep'
      ],
      'Q': [
        'equal',
        'quote',
        'squat',
        'query',
        'equip',
        'quack',
        'quick',
        'quiet',
        'quake',
        'aquas',
        'squire',
        'quote',
        'opaque',
        'acquit',
        'aquatic',
        'equity',
        'marque',
        'squint',
        'mosque',
        'inquire'
      ],
      'R': [
        'ear',
        'ore',
        'era',
        'err',
        'are',
        'her',
        'fir',
        'tar',
        'for',
        'bar',
        'fire',
        'tire',
        'bore',
        'rare',
        'near',
        'fort',
        'core',
        'mire',
        'bard',
        'fern',
        'prior',
        'lunar',
        'order',
        'arbor',
        'drain',
        'lured'
      ],
      'S': [
        'Sac',
        'Sad',
        'Sat',
        'Saw',
        'Say',
        'Sea',
        'See',
        'Set',
        'Sip',
        'Sit',
        'Base',
        'Case',
        'Dose',
        'Fuse',
        'Lose',
        'Funds',
        'Gains',
        'girls',
        'golds',
        'Hairs'
      ],
      'T': [
        'Tea',
        'Ten',
        'Tie',
        'Toe',
        'Ton',
        'Top',
        'Toy',
        'Try',
        'Tub',
        'Tap',
        'Rate',
        'Site',
        'Vote',
        'Cute',
        'Lite',
        'About',
        'Ghost',
        'Light',
        'Right',
        'Night'
      ],
      'U': [
        'umm',
        'ump',
        'ugh',
        'uke',
        'umu',
        'upo',
        'ups',
        'urb',
        'ulu',
        'uni',
        'Tune',
        'Cube',
        'Tube',
        'Pure',
        'Cure',
        'Adieu',
        'Barbu',
        'Bayou',
        'Bijou',
        'Buchu'
      ],
      'V': [
        'Van',
        'Vet',
        'Vex',
        'Via',
        'veg',
        'vip',
        'vid',
        'vow',
        'vol',
        'var',
        'Cave',
        'Dive',
        'Give',
        'Love',
        'Live',
        'ganev',
        'ollav',
        'parev',
        'schav',
        'Kirov'
      ],
      'W': [
        'Wet',
        'Who',
        'Why',
        'Win',
        'War',
        'Was',
        'Wax',
        'Way',
        'Web',
        'Wed',
        'Awe',
        'Ewe',
        'Owe',
        'Uwe',
        'Yew',
        'Arrow',
        'Below',
        'Elbow',
        'Throw',
        'Widow'
      ],
      'X': [
        'Xat',
        'Xes',
        'Xis',
        'Xie',
        'Xin',
        'Xan',
        'Xav',
        'Xem',
        'Xer',
        'Xia',
        'Axel',
        'Apex',
        'Axle',
        'Axon',
        'Oxid',
        'inbox',
        'index',
        'relax',
        'remix',
        'detox'
      ],
      'Y': [
        'Yak',
        'Yam',
        'Yap',
        'You',
        'Yay',
        'Yea',
        'Yep',
        'Yes',
        'Yet',
        'Yew',
        'Byte',
        'Gyre',
        'Tyre',
        'Pyre',
        'Lyre',
        'Happy',
        'Candy',
        'Party',
        'Fancy',
        'Honey'
      ],
      'Z': [
        'Zoo',
        'Zap',
        'Zip',
        'Zit',
        'Zee',
        'Zed',
        'Zag',
        'Zas',
        'Zep',
        'Zen',
        'daze',
        'faze',
        'gaze',
        'gazy',
        'haze',
        'blitz',
        'bortz',
        'fritz',
        'hertz',
        'glitz'
      ],
      // Define words for other letters similarly
      // ...
    };
    words = wordMap[widget.selectedLetter]!;
    words.shuffle();
    words = words.take(6).toList();
  }

  void initializeButtonColors() {
    for (int i = 0; i < words.length; i++) {
      buttonColors[i] = Colors.blue;
    }
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void _showProgressReport(BuildContext context) {
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
              child: _buildProgressChart(),
            ),
            SizedBox(height: 10),
            Text('Total Questions Attempted: $totalQuestionsAttempted'),
            Text('Total Correct Answers: $totalCorrectAnswers'),
            Text('Total Wrong Answers: $totalWrongAnswers'),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart() {
    final List<ProgressData> data = [
      ProgressData('Correct', totalCorrectAnswers),
      ProgressData('Wrong', totalWrongAnswers),
    ];

    return charts.BarChart(
      [
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
      ],
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Exercise',
          style: TextStyle(fontFamily: 'openDyslexic'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                generateWords();
                initializeButtonColors();
                wordAnswered = [false, false, false, false, false, false];
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "Choose the letter you learned",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'openDyslexic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (int i = 0; i < words.length; i++)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int j = 0; j < words[i].length; j++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: wordAnswered[i]
                                    ? null
                                    : () {
                                        if (words[i][j].toLowerCase() ==
                                            widget.selectedLetter
                                                .toLowerCase()) {
                                          setState(() {
                                            buttonColors[i] = Colors.green;
                                            showCorrectAnswerDialog();
                                            totalQuestionsAttempted++;
                                            totalCorrectAnswers++;
                                            wordAnswered[i] = true;
                                          });
                                          playSound("audio/yay.mp3");
                                        } else {
                                          setState(() {
                                            buttonColors[i] = Colors.red;
                                            showWrongAnswerDialog();
                                            totalQuestionsAttempted++;
                                            totalWrongAnswers++;
                                          });
                                          playSound("audio/wrong.mp3");
                                        }
                                      },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    return buttonColors[i]!;
                                  }),
                                ),
                                child: Text(
                                  words[i][j],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'OpenDyslexic',
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                              width:
                                  9), // Add space between each word horizontally
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProgressReport(context);
        },
        child: Icon(Icons.bar_chart),
        backgroundColor: Colors.white,
      ),
    );
  }

  void showCorrectAnswerDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Correct Answer!',
            style: TextStyle(color: Colors.green, fontFamily: 'OpenDyslexic')),
        content: Image.asset(
          "images/Monkey2.gif",
          width: 150,
          height: 150,
        ),
      ),
    );
  }

  void showWrongAnswerDialog() {
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

class ProgressData {
  final String status;
  final int value;

  ProgressData(this.status, this.value);
}
