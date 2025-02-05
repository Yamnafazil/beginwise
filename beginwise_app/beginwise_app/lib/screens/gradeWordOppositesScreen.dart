import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GradeWordOppositesScreen extends StatefulWidget {
  @override
  _OppositesLearningScreenState createState() => _OppositesLearningScreenState();
}

class _OppositesLearningScreenState extends State<GradeWordOppositesScreen> {
  String feedbackMessage = '';
  Color feedbackColor = Colors.red;
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        title: const Text("Let's Learn Opposite Words"),
        backgroundColor: Color(0xFFEF923E),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Word Opposites Table
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(color: Color(0xFFEF923E)), // Changed to EF923E
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Color(0xFFEF923E)), // Changed to EF923E
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('Word', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('Opposite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        _buildTableRow("Big", "Small"),
                        _buildTableRow("Hot", "Cold"),
                        _buildTableRow("Fast", "Slow"),
                        _buildTableRow("Happy", "Sad"),
                        _buildTableRow("Tall", "Short"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text("Match the Opposites", style: TextStyle(fontSize: 26, color: Color(0xFFEF923E), fontWeight: FontWeight.bold)), // Changed to EF923E
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  DraggableWord(word: 'Big', opposite: 'Small'),
                  DraggableWord(word: 'Small', opposite: 'Big'),
                  DraggableWord(word: 'Hot', opposite: 'Cold'),
                  DraggableWord(word: 'Cold', opposite: 'Hot'),
                  DraggableWord(word: 'Fast', opposite: 'Slow'),
                  DraggableWord(word: 'Slow', opposite: 'Fast'),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  DropBox(label: 'Small', opposite: 'Big', onDrop: _onDrop),
                  DropBox(label: 'Big', opposite: 'Small', onDrop: _onDrop),
                  DropBox(label: 'Cold', opposite: 'Hot', onDrop: _onDrop),
                  DropBox(label: 'Hot', opposite: 'Cold', onDrop: _onDrop),
                  DropBox(label: 'Slow', opposite: 'Fast', onDrop: _onDrop),
                  DropBox(label: 'Fast', opposite: 'Slow', onDrop: _onDrop),
                ],
              ),
              const SizedBox(height: 40),
              // Feedback
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(feedbackMessage,
                    key: ValueKey(feedbackMessage),
                    style: TextStyle(fontSize: 20, color: feedbackColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String word, String opposite) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(16), child: Text(word, style: TextStyle(fontSize: 18))),
        Padding(padding: const EdgeInsets.all(16), child: Text(opposite, style: TextStyle(fontSize: 18))),
      ],
    );
  }

  void _onDrop(String droppedWord, String correctWord) {
    setState(() {
      if (droppedWord == correctWord) {
        feedbackMessage = "Correct! $droppedWord matches with $correctWord.";
        feedbackColor = Colors.green;
        _speak(feedbackMessage);
      } else {
        feedbackMessage = "Incorrect! Try again.";
        feedbackColor = Colors.red;
        _speak(feedbackMessage);
      }
    });
  }

  void _speak(String text) async {
    await flutterTts.speak(text);
  }
}

class DraggableWord extends StatelessWidget {
  final String word;
  final String opposite;

  const DraggableWord({Key? key, required this.word, required this.opposite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: word,
      child: DraggableContainer(word: word),
      feedback: DraggableContainer(word: word),
      childWhenDragging: DraggableContainer(word: word),
    );
  }
}

class DropBox extends StatelessWidget {
  final String label;
  final String opposite;
  final Function(String, String) onDrop;

  const DropBox({
    Key? key,
    required this.label,
    required this.opposite,
    required this.onDrop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (data) {
        onDrop(data, opposite);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Color(0xFFEF923E)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        );
      },
    );
  }
}

class DraggableContainer extends StatelessWidget {
  final String word;

  const DraggableContainer({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFEF923E),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Text(word, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
