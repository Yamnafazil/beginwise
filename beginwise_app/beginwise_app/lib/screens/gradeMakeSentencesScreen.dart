import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class GradeMakeSentencesScreen extends StatefulWidget {
  @override
  _GradeMakeSentencesScreenState createState() => _GradeMakeSentencesScreenState();
}

class _GradeMakeSentencesScreenState extends State<GradeMakeSentencesScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String selectedLikeObject = '';
  String selectedHaveObject = '';
  String feedbackText = '';

  // Function to handle text-to-speech
  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  // Function to check sentence answers
  void checkSentenceAnswers() {
    setState(() {
      feedbackText = '';
      if (selectedLikeObject.isNotEmpty) {
        feedbackText += 'Great! You like $selectedLikeObject. ';
      } else {
        feedbackText += "Please select an object for 'I like'. ";
      }

      if (selectedHaveObject.isNotEmpty) {
        feedbackText += 'Great! You have $selectedHaveObject. ';
      } else {
        feedbackText += "Please select an object for 'I have'. ";
      }

      speak(feedbackText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFFEF923E);

    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Learn A/An!"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teaching Section
            Text(
              "Understanding A and An",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            SizedBox(height: 8),
            Text(
              "A is used before words that start with a consonant sound. An is used before words that start with a vowel sound.",
            ),
            SizedBox(height: 8),
            Text(
              "Examples: A cat, An apple.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/img/kg_english/CAT1.png', height: 140),
                Image.asset('assets/img/kg_english/apple.png', height: 140),
              ],
            ),
            SizedBox(height: 32),

            // Sentence Making Section
            Text(
              "Examples of Sentences",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            SizedBox(height: 8),
            DataTable(
              columns: [
                DataColumn(label: Text('Sentence')),
              ],
              rows: [
                DataRow(cells: [DataCell(Text("I like an apple."))]),
                DataRow(cells: [DataCell(Text("I have a cat."))]),
                DataRow(cells: [DataCell(Text("I like a dog."))]),
                DataRow(cells: [DataCell(Text("I have an orange."))]),
              ],
            ),
            SizedBox(height: 16),

            Text(
              "Make a Sentence",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("I like "),
                DropdownButton<String>(
                  value: selectedLikeObject.isEmpty ? null : selectedLikeObject,
                  hint: Text("Select"),
                  onChanged: (value) {
                    setState(() {
                      selectedLikeObject = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(value: "an apple", child: Text("an apple")),
                    DropdownMenuItem(value: "a cat", child: Text("a cat")),
                    DropdownMenuItem(value: "an orange", child: Text("an orange")),
                    DropdownMenuItem(value: "a dog", child: Text("a dog")),
                  ],
                ),
                Text("."),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("I have "),
                DropdownButton<String>(
                  value: selectedHaveObject.isEmpty ? null : selectedHaveObject,
                  hint: Text("Select"),
                  onChanged: (value) {
                    setState(() {
                      selectedHaveObject = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(value: "an apple", child: Text("an apple")),
                    DropdownMenuItem(value: "a cat", child: Text("a cat")),
                    DropdownMenuItem(value: "an orange", child: Text("an orange")),
                    DropdownMenuItem(value: "a dog", child: Text("a dog")),
                  ],
                ),
                Text("."),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: checkSentenceAnswers,
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text("Check Answers", style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
            SizedBox(height: 16),
            if (feedbackText.isNotEmpty)
              Text(
                feedbackText,
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
