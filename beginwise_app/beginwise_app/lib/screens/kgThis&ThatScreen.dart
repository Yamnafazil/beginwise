import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class KgThisThat extends StatefulWidget {
  @override
  _KgThisThatState createState() => _KgThisThatState();
}

class _KgThisThatState extends State<KgThisThat> {
  final FlutterTts flutterTts = FlutterTts();

  void speakFeedback(String message) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0); // Adjust pitch if needed
    await flutterTts.setSpeechRate(0.5); // Adjust speed if needed
    await flutterTts.speak(message);
  }

  void checkAnswer(String selectedAnswer, String correctAnswer, String correctPhrase) {
    String feedbackMessage;
    if (selectedAnswer == correctAnswer) {
      feedbackMessage = "Correct! You would say: $correctPhrase";
    } else {
      feedbackMessage = "Oops! You would say: $correctPhrase";
    }

    // Speak the feedback
    speakFeedback(feedbackMessage);

    // Show a dialog with feedback
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            selectedAnswer == correctAnswer ? 'Correct!' : 'Oops!',
            style: TextStyle(color: selectedAnswer == correctAnswer ? Colors.green : Colors.red),
          ),
          content: Text(
            feedbackMessage,
            style: TextStyle(color: selectedAnswer == correctAnswer ? Colors.green : Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Learn the Use of 'This' and 'That'",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E), // Teal color
      ),
      body: SingleChildScrollView( // Wrap the content with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "What would you say about this cat?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEF923E),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "This is used for something that is near you.\nThat is used for something that is far away.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF455a64)),
              ),
              SizedBox(height: 30),
              Image.asset("assets/img/kg_english/cat.png", width: 100),
              SizedBox(height: 20),
              Text(
                "What would you say about this cat?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => checkAnswer('this', 'this', 'This is a cat.'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text("This is a cat."),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => checkAnswer('that', 'this', 'This is a cat.'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text("That is a cat."),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "What would you say about that car?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFEF923E)),
              ),
              SizedBox(height: 20),
              Image.asset("assets/img/kg_english/car.png", width: 100),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => checkAnswer('this', 'that', 'That is a car.'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text("This is a car."),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => checkAnswer('that', 'that', 'That is a car.'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text("That is a car."),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "What would you say about that mountain?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFEF923E)),
              ),
              SizedBox(height: 20),
              Image.asset("assets/img/kg_english/mountain.png", width: 100),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => checkAnswer('this', 'that', 'That is a mountain.'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text("This is a mountain."),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => checkAnswer('that', 'that', 'That is a mountain.'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text("That is a mountain."),
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
