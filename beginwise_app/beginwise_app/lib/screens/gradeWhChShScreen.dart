import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeWhChShScreen extends StatefulWidget {
  @override
  _GradeWhChShScreenState createState() => _GradeWhChShScreenState();
}

class _GradeWhChShScreenState extends State<GradeWhChShScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final Map<String, String> soundToWord = {
    'CH': 'chair',
    'SH': 'shoes',
    'WH': 'whale',
    'TH': 'thumb',
  };
  final Map<String, bool> matchedWords = {};
  String feedback = '';
  Color feedbackColor = Colors.black;

  @override
  void initState() {
    super.initState();
    for (var sound in soundToWord.keys) {
      matchedWords[sound] = false;
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  void onDragAccepted(String sound, String word) {
    setState(() {
      if (soundToWord[sound] == word) {
        matchedWords[sound] = true;
        feedback = "Correct! You matched $sound with $word.";
        feedbackColor = Colors.green;
        speak(feedback);
      } else {
        feedback = "Try again! That wasn't the right match.";
        feedbackColor = Colors.red;
        speak(feedback);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's Learn CH, SH, WH, and TH Sounds!"),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Flashcards: Tap to Hear the Sound",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
              physics: const NeverScrollableScrollPhysics(),
              children: soundToWord.entries.map((entry) {
                return GestureDetector(
                  onTap: () => speak('${entry.key} for ${entry.value}'),
                  child: Card(
                    elevation: 4,
                    color: Color(0xFFFFE0B2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/kg_english/${entry.value}.png',
                          height: 60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${entry.key} - ${entry.value}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Drag the Sound to the Correct Image",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: soundToWord.keys.map((sound) {
                return Draggable<String>(
                  data: sound,
                  feedback: Material(
                    child: Chip(
                      label: Text(sound),
                      backgroundColor: Color(0xFFEF923E),
                    ),
                  ),
                  childWhenDragging: Chip(
                    label: Text(sound),
                    backgroundColor: Colors.grey.shade400,
                  ),
                  child: Chip(
                    label: Text(sound),
                    backgroundColor: Color(0xFFEF923E),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: soundToWord.values.map((word) {
                return DragTarget<String>(
                  onAccept: (data) => onDragAccepted(data, word),
                  builder: (context, accepted, rejected) {
                    final isMatched = matchedWords.entries
                        .any((entry) => entry.value && soundToWord[entry.key] == word);
                    return Container(
                      width: 120,
                      height: 140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: isMatched ? Colors.green.shade100 : Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/kg_english/$word.png',
                            height: 80,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isMatched ? word.toUpperCase() : 'Drop here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isMatched ? Colors.green : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(
                fontSize: 16,
                color: feedbackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),

    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
