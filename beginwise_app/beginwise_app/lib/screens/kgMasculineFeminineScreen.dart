import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

void main() {
  runApp(KgMasculineFeminineApp());
}

class KgMasculineFeminineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KgMasculineFeminine(),
    );
  }
}

class KgMasculineFeminine extends StatefulWidget {
  @override
  _KgMasculineFeminineState createState() => _KgMasculineFeminineState();
}

class _KgMasculineFeminineState extends State<KgMasculineFeminine> {
  final Color mainColor = Color(0xFFEF923E);
  String feedbackMessage = '';
  bool isCorrect = false;

  // Initialize FlutterTTS
  FlutterTts flutterTts = FlutterTts();

  // Define the data for drag and drop
  final List<String> dragItems = ['Father', 'Mother', 'Brother', 'Sister', 'Grandfather', 'Grandmother'];

  // Variables to track the items dropped into each zone
  String? masculineDropped = null;
  String? feminineDropped = null;

  bool isGameComplete = false; // Flag to check if the game is complete

  @override
  void initState() {
    super.initState();
    // Set initial language for TTS
    flutterTts.setLanguage("en-US");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Kindergarten Masculine and Feminine Learning',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
      ),
      body: SingleChildScrollView( // Wrap the entire body in a SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Masculine and Feminine Learning',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              SizedBox(height: 20),

              // Instructions
              Text(
                'Let\'s learn about Masculine and Feminine!',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),

              // Table displaying masculine and feminine examples
              _buildExampleTable(),

              // Drag and Drop sections
              _buildDragDropSection('Father', 'Mother', 'assets/img/kg_english/man.png', 'assets/img/kg_english/woman.png'),
              _buildDragDropSection('Brother', 'Sister', 'assets/img/kg_english/boy.png', 'assets/img/kg_english/girl.png'),

              // Feedback Message
              if (feedbackMessage.isNotEmpty)
                Text(
                  feedbackMessage,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),

              // Play Again Button
              if (isGameComplete)
                ElevatedButton(
                  onPressed: _resetGame,
                  child: Text('Play Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  // Table for Masculine and Feminine examples
  Widget _buildExampleTable() {
    return Table(
      border: TableBorder.all(color: mainColor),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: mainColor,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Masculine',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Feminine',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Father', style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Mother', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Grandfather', style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Grandmother', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Brother', style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Sister', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Uncle', style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Aunt', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ],
    );
  }

  // Create a drag-and-drop section for each pair with images
  Widget _buildDragDropSection(String masculine, String feminine, String masculineImage, String feminineImage) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Masculine drop zone
            _buildDropZone(masculine, masculineImage, true),
            SizedBox(width: 20),
            // Feminine drop zone
            _buildDropZone(feminine, feminineImage, false),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Draggable masculine with image
            _buildDraggable(masculine, masculineImage, true),
            SizedBox(width: 20),
            // Draggable feminine with image
            _buildDraggable(feminine, feminineImage, false),
          ],
        ),
      ],
    );
  }

  // Draggable widget with image
  Widget _buildDraggable(String label, String imagePath, bool isMasculine) {
    return Draggable<String>(
      data: label,
      child: _buildDraggableBox(label, imagePath),
      feedback: Material(
        color: Colors.transparent,
        child: _buildDraggableBox(label, imagePath),
      ),
      childWhenDragging: _buildDraggableBox(label, imagePath, isDragging: true),
    );
  }

  // Drop zone widget with image and text
  Widget _buildDropZone(String label, String imagePath, bool isMasculine) {
    return DragTarget<String>(onWillAccept: (data) => data == label, onAccept: (data) {
      setState(() {
        // Update the appropriate dropped item
        if (isMasculine) {
          masculineDropped = label;
        } else {
          feminineDropped = label;
        }

        // Provide feedback
        feedbackMessage = data == label ? 'Correct!' : 'Try Again!';
        isCorrect = data == label;

        // Speak the feedback message
        flutterTts.speak(feedbackMessage);

        // Check if the game is complete
        if (masculineDropped != null && feminineDropped != null) {
          isGameComplete = true;
        }
      });
    }, builder: (context, candidateData, rejectedData) {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: mainColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isMasculine ? 'Masculine' : 'Feminine',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              (isMasculine ? masculineDropped : feminineDropped) == label
                  ? Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  // Build the draggable box style with image
  Widget _buildDraggableBox(String label, String imagePath, {bool isDragging = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: mainColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Reset the game state
  void _resetGame() {
    setState(() {
      masculineDropped = null;
      feminineDropped = null;
      isGameComplete = false;
      feedbackMessage = '';
    });
  }
}
