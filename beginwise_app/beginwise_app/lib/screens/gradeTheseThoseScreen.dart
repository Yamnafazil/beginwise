import 'package:flutter/material.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GradeTheseThoseScreen extends StatefulWidget {
  @override
  _GradeTheseThoseScreenState createState() => _GradeTheseThoseScreenState();
}

class _GradeTheseThoseScreenState extends State<GradeTheseThoseScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn This, That, These, Those!'),
        backgroundColor: Color(0xFFEF923E), // Updated AppBar color
      ),
      body: SingleChildScrollView(
        // Wrap the entire body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Drag and Drop Activity',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFEF923E)),
              ),
              const SizedBox(height: 10),

              // Interactive Drag and Drop section
              InteractiveDragDropSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class InteractiveDragDropSection extends StatefulWidget {
  @override
  _InteractiveDragDropSectionState createState() =>
      _InteractiveDragDropSectionState();
}

class _InteractiveDragDropSectionState extends State<InteractiveDragDropSection> {
  FlutterTts flutterTts = FlutterTts();
  String feedback = '';
  Map<String, String> correctAnswers = {
    'cat': 'This',
    'car': 'That',
    'apples': 'These',
    'cars': 'Those',
    'books': 'There Are',
  };
  Map<String, bool> completedTargets = {
    'cat': false,
    'car': false,
    'apples': false,
    'cars': false,
    'books': false,
  };

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('en-US');
    flutterTts.setSpeechRate(0.5); // Set the speech rate (0.0 - 1.0)
    flutterTts.setPitch(1.0); // Set the pitch (0.5 - 2.0)
  }

  // Function to show feedback in a popup and speak the feedback
  void _showFeedbackDialog(String message, {bool showPlayAgain = false}) {
    flutterTts.speak(message); // Speak the feedback message

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message.startsWith('Correct') ? 'Correct Answer' : (showPlayAgain ? 'Congratulations!' : 'Incorrect Answer'),
            style: TextStyle(
              color: message.startsWith('Correct') ? Colors.green : (showPlayAgain ? Colors.blue : Colors.red),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            if (showPlayAgain)
              TextButton(
                child: const Text('Play Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    completedTargets.updateAll((key, value) => false);
                  });
                },
              ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Drag the correct word to match the picture:',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),

        // Draggable words
        Wrap(
          spacing: 15,
          runSpacing: 10, // Ensure there is space between rows
          children: correctAnswers.values.map((word) {
            return Draggable<String>(
              data: word,
              feedback: Material(
                color: Colors.transparent,
                child: Chip(
                  label: Text(
                    word,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Color(0xFFEF923E),
                ),
              ),
              childWhenDragging: Chip(
                label: Text(word),
                backgroundColor: Colors.grey,
              ),
              child: Card(
                color: Color(0xFFFFE0B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(word, style: TextStyle(fontSize: 18)),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Drag targets with images
        Wrap(
          spacing: 10,
          runSpacing: 10, // Ensure there is space between rows
          children: correctAnswers.keys.map((key) {
            return DragTarget<String>(
              onWillAccept: (data) => data != null,
              onAccept: (data) {
                setState(() {
                  if (data == correctAnswers[key]) {
                    completedTargets[key] = true;
                    feedback = 'Correct! "$data" matches "$key".';
                    _showFeedbackDialog(feedback);

                    if (completedTargets.values.every((completed) => completed)) {
                      _showFeedbackDialog('Congratulations! You matched all correctly!', showPlayAgain: true);
                    }
                  } else {
                    feedback = 'Incorrect. "$data" does not match "$key". Try again!';
                    _showFeedbackDialog(feedback);
                  }
                });
              },
              builder: (context, accepted, rejected) {
                return completedTargets[key]!
                    ? Container(
                  width: 180,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                )
                    : Card(
                  color: accepted.isEmpty ? Colors.grey.shade200 : Color(0xFFC8E6C9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  child: Container(
                    width: 180,
                    height: 200,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/kg_english/$key.png',
                          width: 140,
                          height: 140,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          key.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEF923E),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

