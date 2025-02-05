import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeBodyScreen extends StatefulWidget {
  @override
  _GradeBodyScreenState createState() => _GradeBodyScreenState();
}

class _GradeBodyScreenState extends State<GradeBodyScreen> {
  late VideoPlayerController _controller;
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();

    // Initialize Video Player
    _controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/jism%20k%20hissay.mp4?alt=media&token=ddcb1628-fd27-4a31-96b2-b5bee917eb44',
    )
      ..initialize().then((_) {
        setState(() {
          _controller.play(); // Auto-play the video after initialization
        });
      }).catchError((error) {
        print('Error initializing video: $error');
      });

    // Initialize Text-to-Speech
    _flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _controller.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  // Function to speak the text
  void speakText(String text) async {
    await _flutterTts.setLanguage('ur-PK');
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حصّے جسم'),
        backgroundColor: Color(0xFFEF923E), // Applying the color to the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Video Section
              if (_controller.value.isInitialized)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: Color(0xFFEF923E), // Orange progress bar
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 40,
                            color: Color(0xFFEF923E), // Orange play/pause button
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
                      ),
                    ],
                  ),
                )
              else
                Center(child: CircularProgressIndicator()),

              // Definition Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'حصّے جسم: جسم کے مختلف حصے جیسے سر، آنکھ، ناک وغیرہ جو انسانی جسم کی بناوٹ کا حصہ ہیں۔',
                  style: TextStyle(fontSize: 18, color: Color(0xFFEF923E)), // Orange text
                ),
              ),

              // Table Section with Images and Speak Buttons
              DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('تصویر')),
                  DataColumn(label: Text('حصّے جسم')),
                  DataColumn(label: Text('سنیں')),
                ],
                rows: [
                  _buildRow('assets/img/38.png', 'سر'),
                  _buildRow('assets/img/39.png', 'آنکھ'),
                  _buildRow('assets/img/40.png', 'ناک'),
                  _buildRow('assets/img/41.png', 'کان'),
                  _buildRow('assets/img/42.png', 'منہ'),
                  _buildRow('assets/img/43.png', 'ہاتھ'),
                  _buildRow('assets/img/44.png', 'پیر'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  // Helper function to create each row
  DataRow _buildRow(String imagePath, String text) {
    return DataRow(
      cells: [
        DataCell(Image.asset(imagePath, width: 100, height: 100)),
        DataCell(Text(text, style: TextStyle(color: Color(0xFFEF923E)))), // Orange text
        DataCell(
          IconButton(
            icon: Icon(Icons.volume_up, color: Color(0xFFEF923E)), // Orange icon
            onPressed: () => speakText(text),
          ),
        ),
      ],
    );
  }
}
