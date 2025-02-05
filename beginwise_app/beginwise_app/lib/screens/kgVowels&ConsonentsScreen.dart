import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class KgVowelsConsonents extends StatefulWidget {
  @override
  _VowelsConsonantsState createState() => _VowelsConsonantsState();
}

class _VowelsConsonantsState extends State<KgVowelsConsonents> {
  final correctVowels = 'AEIOU';
  final correctConsonants = 'BCDFGHJKLMNPQRSTVWXYZ';
  String feedbackMessage = '';
  bool isSuccess = false;

  VideoPlayerController? _controller; // Use VideoPlayerController
  FlutterTts _flutterTts = FlutterTts(); // Initialize FlutterTTS instance

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  // Initialize video player
  void _initializeVideo() {
    _controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/The%20Short%20Vowel%20Song%20.mp4?alt=media&token=590324d7-e9ae-4302-bbb4-2783bb061845',
    )..initialize().then((_) {
      setState(() {}); // Rebuild widget once video is initialized
      _controller!.play(); // Automatically play video once loaded
    }).catchError((e) {
      print('Error loading video: $e');
    });
  }

  void showFeedback(String message, bool isSuccess) {
    setState(() {
      feedbackMessage = message;
      this.isSuccess = isSuccess;
    });

    // Speak the feedback message
    _flutterTts.speak(message);

    // Display feedback in a popup dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Correct!' : 'Incorrect!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
    print(message);
  }

  // Function to toggle the video playback (play or pause)
  void _toggleVideo() {
    if (_controller != null && _controller!.value.isInitialized) {
      if (_controller!.value.isPlaying) {
        _controller!.pause(); // Pause the video if it's currently playing
      } else {
        _controller!.play(); // Play the video if it's paused
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Vowels and Consonants',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Header
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Let\'s Learn Vowels and Consonants',
                  style: TextStyle(fontSize: 48, color: Color(0xFFEF923E), fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              // Video Section
              _controller != null && _controller!.value.isInitialized
                  ? GestureDetector(
                onTap: _toggleVideo, // Toggle video play/pause on tap
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: VideoPlayer(_controller!),
                  ),
                ),
              )
                  : Center(child: CircularProgressIndicator()),

              // Vowels Quiz Section
              Text(
                'Select the Vowels',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFF5200)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: List.generate(10, (index) {
                  String letter = 'ABCDEFGHIJ'.substring(index, index + 1);
                  return GestureDetector(
                    onTap: () {
                      if (correctVowels.contains(letter.toUpperCase())) {
                        showFeedback('Correct! This is a vowel.', true);
                      } else {
                        showFeedback('Incorrect. Please try again.', false);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: getColorForButton(index),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.15))
                        ],
                      ),
                      child: Text(
                        letter.toLowerCase(),
                        style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
              ),

              // Consonants Quiz Section
              SizedBox(height: 30),
              Text(
                'Select the Consonants',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFF5200)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: List.generate(10, (index) {
                  String letter = 'ABCDEFGHIJ'.substring(index, index + 1);
                  return GestureDetector(
                    onTap: () {
                      if (correctConsonants.contains(letter.toUpperCase())) {
                        showFeedback('Correct! This is a consonant.', true);
                      } else {
                        showFeedback('Incorrect. Please try again.', false);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: getColorForButton(index),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.15))
                        ],
                      ),
                      child: Text(
                        letter.toLowerCase(),
                        style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Color getColorForButton(int index) {
    List<Color> colors = [
      Color(0xFFAD1AE5),
      Color(0xFF01A3FE),
      Color(0xFFFF0067),
      Color(0xFFF3FF00),
      Color(0xFFC74838),
      Color(0xFF0BF459),
      Color(0xFF0984E3),
      Color(0xFFFF4200),
      Color(0xFFFF009B),
      Color(0xFFED02FD),
    ];
    return colors[index % colors.length];
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose(); // Dispose video controller to release resources
    _flutterTts.stop(); // Stop TTS when the widget is disposed
  }
}
