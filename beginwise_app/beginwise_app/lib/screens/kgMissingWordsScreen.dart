import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

void main() {
  runApp(KgMissingWords());
}

class KgMissingWords extends StatefulWidget {
  @override
  _KgMissingWordsState createState() => _KgMissingWordsState();
}

class _KgMissingWordsState extends State<KgMissingWords> {
  final FlutterTts flutterTts = FlutterTts(); // Initialize Text-to-Speech
  final List<Map<String, dynamic>> words = [
    {
      'word': '_all',
      'correctLetter': 'b',
      'image': 'assets/img/kg_english/ball.png',
    },
    {
      'word': '_og',
      'correctLetter': 'd',
      'image': 'assets/img/kg_english/dog.png',
    },
    {
      'word': '_at',
      'correctLetter': 'c',
      'image': 'assets/img/kg_english/CAT1.png',
    },
    {
      'word': '_oy',
      'correctLetter': 'b',
      'image': 'assets/img/kg_english/boy.png',
    },
    {
      'word': '_ish',
      'correctLetter': 'f',
      'image': 'assets/img/kg_english/fish.png',
    },
    {
      'word': '_ite',
      'correctLetter': 'k',
      'image': 'assets/img/kg_english/kite.png',
    },
    {
      'word': '_at',
      'correctLetter': 'h',
      'image': 'assets/img/kg_english/hat.png',
    }
  ];

  int currentIndex = 0;
  String feedbackMessage = '';
  bool isNextWordVisible = false;
  bool isCongratsVisible = false;

  // Function to speak feedback messages
  void speak(String message) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(message);
  }

  void checkLetter(String selectedLetter, String correctLetter) {
    setState(() {
      if (selectedLetter == correctLetter) {
        feedbackMessage = 'Well done! You found the missing letter!';
        isNextWordVisible = true;
        speak(feedbackMessage); // Speak the correct message
      } else {
        feedbackMessage = 'Try again!';
        speak(feedbackMessage); // Speak the incorrect message
      }
    });
  }

  void hintFunction() {
    setState(() {
      final correctLetter = words[currentIndex]['correctLetter'];
      feedbackMessage = "The missing letter is '$correctLetter'.";
      speak(feedbackMessage); // Speak the hint message
    });
  }

  void nextWordFunction() {
    setState(() {
      currentIndex++;
      if (currentIndex < words.length) {
        isNextWordVisible = false;
        feedbackMessage = '';
      } else {
        isCongratsVisible = true;
        feedbackMessage = "Congratulations! You've completed all the words!";
        speak(feedbackMessage); // Speak the congratulatory message
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = words[currentIndex];
    final word = currentWord['word'];
    final correctLetter = currentWord['correctLetter'];
    final image = currentWord['image'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kindergarten Find the Missing Letters!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Use the accent color for the app bar title
            ),),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView( // Make the content scrollable
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find the Missing Letters!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    word,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Image.asset(image, width: 120),
                  SizedBox(height: 20),
                  // Use a Wrap widget to prevent overflow
                  Wrap(
                    spacing: 8.0, // Horizontal space between buttons
                    runSpacing: 4.0, // Vertical space between lines of buttons
                    alignment: WrapAlignment.center, // Align buttons to the center
                    children: List.generate(26, (index) {
                      final letter = String.fromCharCode(index + 97); // a to z
                      return ElevatedButton(
                        onPressed: () => checkLetter(letter, correctLetter),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          letter.toUpperCase(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  if (feedbackMessage.isNotEmpty)
                    Text(
                      feedbackMessage,
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  SizedBox(height: 10),
                  if (isNextWordVisible)
                    ElevatedButton(
                      onPressed: nextWordFunction,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Next Word',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: hintFunction,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Hint',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  if (isCongratsVisible)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Congratulations! You\'ve completed all the words!',
                        style: TextStyle(fontSize: 24, color: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigation(),
      ),
    );
  }
}
