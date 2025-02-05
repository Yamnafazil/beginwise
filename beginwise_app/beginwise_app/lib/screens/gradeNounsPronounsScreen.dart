import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeNounsPronounsScreen extends StatefulWidget {
  @override
  _GradeNounsPronounsScreenState createState() => _GradeNounsPronounsScreenState();
}

class _GradeNounsPronounsScreenState extends State<GradeNounsPronounsScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String feedback = "";

  // Function to provide speech feedback
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  // Function to show feedback in a dialog box
  void showFeedbackDialog(String feedback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Feedback", style: TextStyle(color: Color(0xFFEF923E))),
          content: Text(
            feedback,
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Nouns, Pronouns, Verbs, and Adjectives'),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Learn Nouns, Pronouns, Verbs, and Adjectives",
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFEF923E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              buildSection(
                title: "Nouns",
                description: "A noun is a person, place, or thing.",
                imagePath: "assets/img/kg_english/apple.png",
                example: "This is an apple. It is a thing, so it's a noun!",
                buttonText: "Click to Learn About Nouns",
                onPressed: () {
                  setState(() {
                    feedback = "A noun is a person, place, or thing.";
                  });
                  speak(feedback);
                  showFeedbackDialog(feedback);  // Show dialog with feedback
                },
              ),
              buildSection(
                title: "Pronouns",
                description:
                "A pronoun is a word that replaces a noun. Instead of saying 'the boy,' we can say 'he'.",
                imagePath: "assets/img/kg_english/boy.png",
                example: "This is a boy. We can replace 'the boy' with 'he'.",
                buttonText: "Click to Learn About Pronouns",
                onPressed: () {
                  setState(() {
                    feedback = "A pronoun replaces a noun.";
                  });
                  speak(feedback);
                  showFeedbackDialog(feedback);  // Show dialog with feedback
                },
              ),
              buildSection(
                title: "Verbs",
                description: "Verbs are action words.",
                imagePath: "assets/img/kg_english/running.png",
                example:
                "The boy is running. Running is a verb because it shows what the boy is doing.",
                buttonText: "Click to Learn About Verbs",
                onPressed: () {
                  setState(() {
                    feedback = "A verb is an action word.";
                  });
                  speak(feedback);
                  showFeedbackDialog(feedback);  // Show dialog with feedback
                },
              ),
              buildSection(
                title: "Adjectives",
                description: "An adjective describes a noun.",
                imagePath: "assets/img/kg_english/bigshirt.jpg",
                example:
                "The boy is wearing a big shirt. The word 'big' describes the shirt. It's an adjective!",
                buttonText: "Click to Learn About Adjectives",
                onPressed: () {
                  setState(() {
                    feedback = "An adjective describes a noun.";
                  });
                  speak(feedback);
                  showFeedbackDialog(feedback);  // Show dialog with feedback
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Match the Words",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFEF923E)),
              ),
              const SizedBox(height: 10),
              Text(
                "Drag the words into the correct category box!",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              buildDragAndDrop(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget buildSection({
    required String title,
    required String description,
    required String imagePath,
    required String example,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFEF923E)),
            ),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Center(  // Center the image
              child: Image.asset(imagePath, height: 150),
            ),
            const SizedBox(height: 10),
            Text(example, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Center(  // Center the button
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF923E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),  // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDragAndDrop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDragBox("Nouns"),
            buildDragBox("Verbs"),
            buildDragBox("Adjectives"),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDraggableItem("Apple", "Nouns"),
            buildDraggableItem("Run", "Verbs"),
            buildDraggableItem("Big", "Adjectives"),
          ],
        ),
      ],
    );
  }

  Widget buildDragBox(String category) {
    return DragTarget<String>(
      onAccept: (data) {
        if (data == category) {
          setState(() {
            feedback = "Correct! You matched the word with its category.";
          });
          speak(feedback);
          showFeedbackDialog(feedback);  // Show dialog with feedback
        } else {
          setState(() {
            feedback = "Oops! Try again.";
          });
          speak(feedback);
          showFeedbackDialog(feedback);  // Show dialog with feedback
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFF3A90C),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            category,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget buildDraggableItem(String label, String category) {
    return Draggable<String>(
      data: category,
      feedback: Material(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF94A06),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
