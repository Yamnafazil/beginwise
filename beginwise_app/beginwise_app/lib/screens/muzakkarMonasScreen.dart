import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class MuzakkarMonasScreen extends StatefulWidget {
  @override
  _MuzakkarMonasScreenState createState() => _MuzakkarMonasScreenState();
}

class _MuzakkarMonasScreenState extends State<MuzakkarMonasScreen> {
  late VideoPlayerController _controller;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    // Initialize the video controller
    _controller = VideoPlayerController.network(
      "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/muzakkar%20mounis.mp4?alt=media&token=ffddfd84-500c-4f61-af18-cafbc064d6c6",
    )..initialize().then((_) {
      setState(() {}); // Refresh UI when video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ur-PK");
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مذکر موؤنث",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFEF923E), // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "مذکر موؤنث",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEF923E), // Heading color
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                    color: Color(0xFFEF923E), // Play/Pause button color
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "مذکر وہ اسم ہے جو مردوں اور نر جنس کے لیے استعمال ہوتا ہے، \nجبکے موؤنث وہ اسم ہے جو عورتوں اور مادہ جنس کے لیے استعمال ہوتا ہے۔",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFEF923E), // Text color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildTableRow("عورت", "مرد"),
                  _buildTableRow("بیٹی", "بیٹا"),
                  _buildTableRow("لڑکی", "لڑکا"),
                  _buildTableRow("استانی", "استاد"),
                  _buildTableRow("ملکہ", "بادشاہ"),
                  _buildTableRow("گائے", "بیل"),
                  _buildTableRow("مرغی", "مرغا"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget _buildTableRow(String feminine, String masculine) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              feminine,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEF923E), // Feminine text color
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              masculine,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEF923E), // Masculine text color
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.volume_up,
              size: 30,
              color: Color(0xFFEF923E), // Icon button color
            ),
            onPressed: () {
              _speak("$feminine، $masculine");
            },
          ),
        ],
      ),
    );
  }
}
