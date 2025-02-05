import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class WaahidJamaScreen extends StatefulWidget {
  @override
  _WaahidJamaScreenState createState() => _WaahidJamaScreenState();
}

class _WaahidJamaScreenState extends State<WaahidJamaScreen> {
  late VideoPlayerController _controller;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    // Initialize the video controller
    _controller = VideoPlayerController.network(
      "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/wahid%20jama.mp4?alt=media&token=6fe12f12-4ffe-4789-9317-685e36f82ebd",
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
          "واحد جمع",
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
              "واحد جمع",
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
              "واحد: وہ لفظ جو ایک چیز، شخص یا جانور کو ظاہر کرے۔\nجمع: وہ لفظ جو ایک سے زیادہ چیزوں، اشخاص یا جانوروں کو ظاہر کرے۔",
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
                  _buildTableRow("انڈا", "انڈے"),
                  _buildTableRow("بلی", "بلیاں"),
                  _buildTableRow("کپڑا", "کپڑے"),
                  _buildTableRow("پودا", "پودے"),
                  _buildTableRow("پیسہ", "پیسے"),
                  _buildTableRow("سیب", "سیب"),
                  _buildTableRow("بیگ", "بیگز"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget _buildTableRow(String singular, String plural) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              singular,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEF923E), // Singular text color
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              plural,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFEF923E), // Plural text color
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
              _speak("$singular، $plural");
            },
          ),
        ],
      ),
    );
  }
}
