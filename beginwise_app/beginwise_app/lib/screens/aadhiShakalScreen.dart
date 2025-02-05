import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class AadhiShakalScreen extends StatefulWidget {
  @override
  _AadhiShakalScreenState createState() => _AadhiShakalScreenState();
}

class _AadhiShakalScreenState extends State<AadhiShakalScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with the video URL
    _controller = VideoPlayerController.network(
      "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/adhi%20ashkal.mp4?alt=media&token=dbc8e8c4-0fdb-442b-b3ff-fe93d2c68aa0",
    )..initialize().then((_) {
      setState(() {}); // Refresh UI when video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "\u0622\u062f\u06be\u06cc \u0627\u0634\u06a9\u0627\u0644",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "\u0622\u062f\u06be\u06cc \u0627\u0634\u06a9\u0627\u0644",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
