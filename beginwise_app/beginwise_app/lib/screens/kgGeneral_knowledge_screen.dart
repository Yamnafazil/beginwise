import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class KgGeneralKnowledgeScreen extends StatefulWidget {
  @override
  _GeneralKnowledgeScreenState createState() => _GeneralKnowledgeScreenState();
}

class _GeneralKnowledgeScreenState extends State<KgGeneralKnowledgeScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  int _currentQuestion = 0;

  // List of questions with answers and images
  final List<Map<String, String>> _questionsWithAnswers = [
    {
      "question": "What is the name of your country?",
      "answer": "The name of my country is Pakistan.",
      "image": "https://img.icons8.com/color/48/000000/country.png"
    },
    {
      "question": "What is the name of your city?",
      "answer": "The name of my city is Karachi.",
      "image": "https://img.icons8.com/color/48/000000/city.png"
    },
    {
      "question": "Who is the founder of Pakistan?",
      "answer": "Quaid-e-Azam Muhammad Ali Jinnah is the founder of Pakistan.",
      "image": "https://img.icons8.com/?size=100&id=110281&format=png&color=000000"
    },
    {
      "question": "What is our national language?",
      "answer": "Our national language is Urdu.",
      "image": "https://img.icons8.com/?size=100&id=0deQ8Ours5Yg&format=png&color=000000"
    },
    {
      "question": "What are the colours of traffic lights?",
      "answer": "The colours of traffic lights are red, yellow, and green.",
      "image": "https://img.icons8.com/color/48/000000/traffic-light.png"
    },
    {
      "question": "How many seasons are there? Name them.",
      "answer": "There are four seasons: Summer, Spring, Winter, Autumn.",
      "image": "https://img.icons8.com/?size=100&id=vRhY7hqLD0iC&format=png&color=000000"
    },
    {
      "question": "How many days are there in a week? Name them.",
      "answer": "There are seven days in a week: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday.",
      "image": "https://img.icons8.com/?size=100&id=imTS7WN6s95I&format=png&color=000000"
    },
    {
      "question": "What is the colour of our national flag?",
      "answer": "The colour of our national flag is green and white.",
      "image": "https://img.icons8.com/?size=100&id=rW6BKNNuxTDd&format=png&color=000000"
    },
    {
      "question": "What is our national game?",
      "answer": "Our national game is hockey.",
      "image": "https://img.icons8.com/?size=100&id=xFrCP5z3PRDB&format=png&color=000000"
    },
    {
      "question": "What is our national dress?",
      "answer": "Our national dress is shalwar kameez.",
      "image": "https://img.icons8.com/?size=100&id=al7OV1jVlvFg&format=png&color=000000"
    },
    {
      "question": "What is the capital of Pakistan?",
      "answer": "Islamabad is the capital of Pakistan.",
      "image": "https://img.icons8.com/?size=100&id=9uHKZ60VvWW2&format=png&color=000000"
    },
  ];

  // Function to speak question and answer
  Future<void> _speakQuestionAndAnswer(String text) async {
    await _flutterTts.setLanguage("en-IN"); // Indian English accent
    await _flutterTts.setSpeechRate(0.5);  // Slow speech rate
    await _flutterTts.setPitch(1.0);      // Neutral pitch
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _flutterTts.stop(); // Clean up when widget is disposed
    super.dispose();
  }

  // Function to move to the next question
  void _nextQuestion() {
    setState(() {
      if (_currentQuestion < _questionsWithAnswers.length - 1) {
        _currentQuestion++;
      }
    });
  }

  // Function to move to the previous question
  void _previousQuestion() {
    setState(() {
      if (_currentQuestion > 0) {
        _currentQuestion--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kindergarten General Knowledge",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "General Knowledge",
                style: TextStyle(
                  fontSize: 48,
                  color: Color(0xFFEF923E),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(offset: Offset(2, 2), color: Colors.yellow, blurRadius: 3),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Display current question and answer
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    _questionsWithAnswers[_currentQuestion]["image"]!,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 15),
                  Text(
                    _questionsWithAnswers[_currentQuestion]["question"]!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _questionsWithAnswers[_currentQuestion]["answer"]!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _speakQuestionAndAnswer(
                          _questionsWithAnswers[_currentQuestion]["question"]! +
                              " " +
                              _questionsWithAnswers[_currentQuestion]["answer"]!);
                    },
                    child: Text("Speak Question and Answer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF923E),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _previousQuestion,
                        child: Text("Previous"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        child: Text("Next"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEF923E),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),

    );
  }
}
