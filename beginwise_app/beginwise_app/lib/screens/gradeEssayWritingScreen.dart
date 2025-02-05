import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeEssayWritingScreen extends StatefulWidget {
  @override
  _GradeEssayWritingScreenState createState() =>
      _GradeEssayWritingScreenState();
}

class _GradeEssayWritingScreenState extends State<GradeEssayWritingScreen> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  // Text of the essay
  final String essayText = """
Essay on Myself

Introduction
Writing an essay about yourself is a fun way to share what you like and who you are with others.

Structure of the Essay
- Introduction: A short paragraph saying your name and who you are.
- Body: Talk about your family, what you like to do, and what makes you special.
- Conclusion: End with something fun about you or what you want to do in the future.

Guidelines for Writing
When you write about yourself, try to answer questions like:
- What is your name?
- Who is in your family?
- What do you like to play or eat?
- What do you want to be when you grow up?

Here is a simple essay written for you:

My Name is Sara
Hi! My name is Sara, and I am 4 years old. I live with my mommy, daddy, and my little sister. We have a big house with a garden where I like to play.

I go to school every day. My favorite thing to do at school is play with my friends. I also love drawing pictures of animals. My favorite color is blue, and I really like dogs. We have a dog named Max, and he is very funny!

When I am at home, I like to eat ice cream and pizza. I also love to ride my bike and play with my toys. When I grow up, I want to be a doctor so I can help people feel better.

I am happy when I play with my family. I love going to the park with my sister and playing on the swings. I like to learn new things, and I want to keep drawing and reading lots of books!
""";

  // Function to read aloud the essay text
  Future<void> readAloud() async {
    if (!isPlaying) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(essayText);
      setState(() {
        isPlaying = true;
      });
    }
  }

  // Function to stop the speech
  Future<void> stopSpeech() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFFEF923E);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grade-1 Essay on Myself'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Essay on Myself',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Divider(color: primaryColor, thickness: 2),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor, width: 1.5),
              ),
              child: Text(
                essayText,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: readAloud,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Read Aloud',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: stopSpeech,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
