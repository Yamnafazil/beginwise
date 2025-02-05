import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeScienceScreen extends StatelessWidget {
  // List of video data
  final List<Map<String, String>> videoData = [
    {
      'image': 'assets/img/urdu_animal.png',
      'title': 'Animal',
      'link': MyRoutes.animalScreen,
    },
    {
      'image': 'assets/img/livingnonliving.png',
      'title': 'Living things & Non Living things',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/livingnonliving.mp4?alt=media&token=ae019faf-10af-4f86-9e7b-2592f3996aae',
    },
    {
      'image': 'assets/img/continents.png',
      'title': 'Oceans',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/oceans.mp4?alt=media&token=abf7b822-19ed-4146-b70e-ecf7bad06c86',
    },
    {
      'image': 'assets/img/conti.png',
      'title': 'Continents',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/continent.mp4?alt=media&token=b140b39a-1f03-4364-bad6-370ad452cfbe',
    },
    {
      'image': 'assets/img/p-of plants.png',
      'title': 'Parts of plants',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/Parts%20of%20a%20Plant.mp4?alt=media&token=24c6bbfd-ff21-4989-b3bf-0763af384d04',
    },
    {
      'image': 'assets/img/body.png',
      'title': 'Parts of body',
      'videoUrl': 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/bodyparts.mp4?alt=media&token=1cbbc068-0592-4a26-9d38-8d6871b8628f',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Science'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Explore science topics',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF555555),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: videoData.length,
                itemBuilder: (context, index) {
                  final item = videoData[index];
                  return GestureDetector(
                    onTap: () {
                      if (item.containsKey('videoUrl') && item['videoUrl'] != null) {
                        // If videoUrl exists, show the video dialog
                        showDialog(
                          context: context,
                          builder: (context) => VideoDialog(
                            videoUrl: item['videoUrl']!,
                            title: item['title']!,
                          ),
                        );
                      } else if (item.containsKey('link') && item['link'] != null) {
                        // If link exists, navigate to the specified screen
                        Navigator.pushNamed(context, item['link']!);
                      } else {
                        // Handle cases where neither videoUrl nor link is provided
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No action available for this item')),
                        );
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
                              width: 200,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10),
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 20,
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
}

class VideoDialog extends StatelessWidget {
  final String videoUrl;
  final String title;

  VideoDialog({required this.videoUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        height: 600,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayerWidget(videoUrl: videoUrl),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return VideoPlayer(_controller);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
