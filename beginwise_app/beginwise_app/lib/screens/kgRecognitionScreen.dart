import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class KgRecognition extends StatefulWidget {
  @override
  _KgRecognitionState createState() => _KgRecognitionState();
}

class _KgRecognitionState extends State<KgRecognition> {
  FlutterTts flutterTts = FlutterTts(); // Initialize Text-to-Speech
  Map<String, String?> droppedImages = {
    'A': null,
    'B': null,
    'C': null,
    'D': null,
    'E': null,
    'F': null,
    'G': null,
    'H': null,
  };

  // Function to handle drag and drop
  void handleDrop(String imageId, String letterId) {
    if ((imageId == 'apple' && letterId == 'A') ||
        (imageId == 'ball' && letterId == 'B') ||
        (imageId == 'cat' && letterId == 'C') ||
        (imageId == 'dog' && letterId == 'D') ||
        (imageId == 'elephant' && letterId == 'E') ||
        (imageId == 'fish' && letterId == 'F') ||
        (imageId == 'grape' && letterId == 'G') ||
        (imageId == 'hat' && letterId == 'H')) {
      setState(() {
        droppedImages[letterId] = imageId;
      });
      showFeedbackDialog("Correct! Well done.", Colors.green);
      speak("Correct! Well done.");

      // Check if all images are matched
      checkCompletion();
    } else {
      showFeedbackDialog("Oops! Try again.", Colors.red);
      speak("Oops! Try again.");
    }
  }

  // Function to check if all images are matched
  void checkCompletion() {
    if (droppedImages.values.every((image) => image != null)) {
      // If all images are matched, show congratulatory dialog
      showCongratulatoryDialog();
      speak("Congratulations! You've completed the game.");
    }
  }

  // Function to show feedback dialog
  void showFeedbackDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: TextStyle(color: color, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Function to show congratulatory dialog
  void showCongratulatoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Congratulations! You've matched all the images correctly.",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                resetGame(); // Reset the game
              },
              child: Text('OK', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Function to reset the game
  void resetGame() {
    setState(() {
      droppedImages = {
        'A': null,
        'B': null,
        'C': null,
        'D': null,
        'E': null,
        'F': null,
        'G': null,
        'H': null,
      };
    });
  }

  // Function to speak the message
  void speak(String message) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(message);
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFFEF923E);

    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop: Match the Image to the Correct Letter' ,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Drag and Drop: Match the Image to the Correct Letter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Column for Letters
                Column(
                  children: [
                    ...['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'].map(
                          (letter) => DragTarget<String>(  // DragTarget for each letter
                        onWillAccept: (data) => true,
                        onAccept: (data) {
                          handleDrop(data, letter);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber[100],
                            ),
                            child: droppedImages[letter] == null
                                ? Text(
                              letter,
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            )
                                : Image.asset(
                              'assets/img/kg_english/${droppedImages[letter]}.png',
                              width: 120,
                              height: 120,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                // Column for Images
                Column(
                  children: [
                    ...['apple', 'ball', 'cat', 'dog', 'elephant', 'fish', 'grape', 'hat'].map(
                          (image) => Draggable<String>(  // Draggable images
                        data: image,
                        child: Image.asset(
                          'assets/img/kg_english/$image.png',
                          width: 120,
                          height: 120,
                        ),
                        feedback: Material(
                          color: Colors.transparent,
                          child: Image.asset(
                            'assets/img/kg_english/$image.png',
                            width: 120,
                            height: 120,
                          ),
                        ),
                        childWhenDragging: Container(),
                      ),
                    ),
                  ],
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
