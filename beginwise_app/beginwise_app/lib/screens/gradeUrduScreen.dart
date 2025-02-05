import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class GradeUrduScreen extends StatelessWidget {
  // List of subjects and their respective video URLs from the internet
  final List<Map<String, String>> subjects = [
    {
      'image': 'assets/img/body.png',
      'title': 'حصّے جسم',
       'link': MyRoutes.gradeBodyScreen,  // Online video URL
    },
    {
      'image': 'assets/img/9.png',
      'title': 'آدھی اشکال',
      'link': MyRoutes.aadhiShakalScreen,  // Online video URL
    },
    {
      'image': 'assets/img/10.png',
      'title': 'الفاظ متضاد',
      'link': MyRoutes.alfaazMutazaadScreen,  // Online video URL
    },
    {
      'image': 'assets/img/singplu.png',
      'title': 'واحد جمع',
      'link': MyRoutes.waahidJamaScreen,  // Online video URL
    },
    {
      'image': 'assets/img/masculinefeminine.png',
      'title': 'مذکر مؤنث',
      'link': MyRoutes.muzakkarMonasScreen,  // Online video URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Urdu',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFEF923E),
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore Urdu Topics',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final item = subjects[index];
                  return GestureDetector(
                    onTap: () {
                      if (item['link']!.endsWith('.mp4')) {
                        _showVideoModal(context, item['link']!);
                      } else {
                        // Navigate to the corresponding screen (you can replace the link with actual screen routing in Flutter)
                        Navigator.pushNamed(context, item['link']!);
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFEF923E), Color(0xFFFFCD3C)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['image']!,
                              width: 180, // Adjusted width for better visibility
                              height: 120, // Adjusted height for better visibility
                              fit: BoxFit.contain, // Ensures image maintains its aspect ratio
                            ),
                            SizedBox(height: 10),
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  // Method to show the video modal
  void _showVideoModal(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Video player (using the video_player package)
              Container(
                width: double.infinity,
                height: 250,
                child: VideoPlayerScreen(url: videoUrl),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the modal
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  VideoPlayerScreen({required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with the video URL
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});  // Refresh UI when video is initialized
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        VideoProgressIndicator(_controller, allowScrubbing: true),
        IconButton(
          icon: Icon(
            _controller.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
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
    )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose the controller when done
  }
}
