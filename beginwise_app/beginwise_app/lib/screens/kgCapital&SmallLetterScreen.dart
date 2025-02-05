import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KgCapitalSmallLetterScreen(),
    );
  }
}

class KgCapitalSmallLetterScreen extends StatefulWidget {
  @override
  _KgCapitalSmallLetterScreenState createState() =>
      _KgCapitalSmallLetterScreenState();
}

class _KgCapitalSmallLetterScreenState
    extends State<KgCapitalSmallLetterScreen> {
  // Correct letters for capital and small letters
  final correctCapital = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final correctSmall = 'abcdefghijklmnopqrstuvwxyz';

  // Video player controller
  late VideoPlayerController _controller;
  bool isPlaying = false; // To track if video is playing

  // Text-to-speech controller
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    // Initialize the video player with the URL using networkUrl (new approach)
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/Uppercase%20Letters%20-%20Learn%20the%20Alphabet%20-%20Grammar%20for%20Kids%20-%20Kids%20Academy_003.mp4?alt=media&token=23bea388-8361-4aca-8c9b-15d887cc81a1'), // Replace with actual URL
    )..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose video controller
  }

  // Function to handle button click
  void handleButtonClick(String letter, String section) {
    String feedbackMessage = '';
    Color feedbackColor = Colors.black;

    if (section == 'capital' && correctCapital.contains(letter)) {
      feedbackMessage = 'Correct! This is a capital letter.';
      feedbackColor = Colors.green;
    } else if (section == 'small' && correctSmall.contains(letter)) {
      feedbackMessage = 'Correct! This is a small letter.';
      feedbackColor = Colors.green;
    } else {
      feedbackMessage = 'Incorrect. Please try again.';
      feedbackColor = Colors.red;
    }

    // Show a popup (dialog) with the feedback message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Feedback',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: feedbackColor,
            ),
          ),
          content: Text(
            feedbackMessage,
            style: TextStyle(
              fontSize: 18,
              color: feedbackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    // Speak the feedback message using text-to-speech
    _flutterTts.speak(feedbackMessage);
  }

  // Toggle play/pause video
  void togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Capital and Small Letters',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Let\'s Learn Capital and Small Letters',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Dynamic Video Section with play/pause buttons
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.grey[300],
                child: Center(
                  child: _controller.value.isInitialized
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: Colors.orange,
                        ),
                        onPressed: togglePlayPause,
                      ),
                    ],
                  )
                      : CircularProgressIndicator(),
                ),
              ),

              SizedBox(height: 30),
              // Capital Letters Quiz Section
              SectionHeader(title: 'Select the Capital Letters'),
              LetterButtons(section: 'capital', onButtonClick: handleButtonClick),

              SizedBox(height: 30),
              // Small Letters Quiz Section
              SectionHeader(title: 'Select the Small Letters'),
              LetterButtons(section: 'small', onButtonClick: handleButtonClick),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
      textAlign: TextAlign.center,
    );
  }
}

class LetterButtons extends StatelessWidget {
  final String section;
  final Function(String, String) onButtonClick;

  LetterButtons({required this.section, required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    List<String> letters = [];

    if (section == 'capital') {
      letters = [
        'A','a' ,'B','b', 'C', 'c','D', 'd','E','e' ,'F','f', 'G','g' ,'H','h', 'I','i' ,'J','j','K','k', 'L','l', 'M','m' ,'N', 'n','O','o' ,'P','p',
        'Q','q' ,'R','r', 'S','s','T', 't','U','u', 'V','v', 'W','w', 'X','x' ,'Y','y' ,'Z','z'
      ];
    } else if (section == 'small') {
      letters = [
        'A','a' ,'B','b' ,'C', 'c','D', 'd','E','e' ,'F','f', 'G','g' ,'H','h', 'I','i' ,'J','j','K','k' ,'L','l', 'M','m' ,'N', 'n','O','o' ,'P','p',
            'Q','q' ,'R','r', 'S','s','T', 't','U','u', 'V','v', 'W','w', 'X','x' ,'Y','y', 'Z','z'
      ];
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      children: letters
          .map((letter) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.primaries[letters.indexOf(letter) % Colors.primaries.length],
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () => onButtonClick(letter, section),
        child: Text(
          letter,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ))
          .toList(),
    );
  }
}
