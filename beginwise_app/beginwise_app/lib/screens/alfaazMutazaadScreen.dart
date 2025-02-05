import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class AlfaazMutazaadScreen extends StatefulWidget {
  @override
  _AlfaazMutazaadScreenState createState() => _AlfaazMutazaadScreenState();
}

class _AlfaazMutazaadScreenState extends State<AlfaazMutazaadScreen> {
  late VideoPlayerController _controller;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    // Initialize the video controller
    _controller = VideoPlayerController.network(
      "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/alfaz%20mutazad.mp4?alt=media&token=a7ed9181-84b9-45ca-9088-b920ddf487b7",
    )..initialize().then((_) {
      setState(() {}); // Refresh UI when video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _speak(String word, String opposite) async {
    await flutterTts.setLanguage("ur-PK");
    await flutterTts.speak("$word، $opposite");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الفاظ متضاد",
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
              "الفاظ متضاد",
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
                    color: Color(0xFFEF923E), // Play/pause button color
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
              "الفاظ متضاد وہ الفاظ ہوتے ہیں جن کے معنی ایک دوسرے کی ضد ہوں۔ مثلاً اچھا اور برا، دن اور رات۔",
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
                  _buildTableRow("اچھا", "برا"),
                  _buildTableRow("اونچا", "نیچا"),
                  _buildTableRow("بڑا", "چھوٹا"),
                  _buildTableRow("لمبا", "چھوٹا"),
                  _buildTableRow("گرم", "ٹھنڈا"),
                  _buildTableRow("دن", "رات"),
                  _buildTableRow("نیا", "پرانا"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget _buildTableRow(String word, String opposite) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              word,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEF923E), // Word color
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              opposite,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEF923E), // Opposite word color
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.volume_up,
              size: 30,
              color: Color(0xFFEF923E), // Icon color
            ),
            onPressed: () {
              _speak(word, opposite);
            },
          ),
        ],
      ),
    );
  }
}
