import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class KgMathsScreen extends StatefulWidget {
  @override
  _KgMathsScreenState createState() => _KgMathsScreenState();
}

class _KgMathsScreenState extends State<KgMathsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindergarten Mathematics',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Mathematics',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFFEF923E),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 10.0,
                    color: Color(0xFFFFCD3C),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),

            // Grid of Cards (Questions)
            GridView.builder(
              shrinkWrap: true, // Use shrinkWrap to prevent overflow
              physics: NeverScrollableScrollPhysics(), // Disable scrolling to prevent overflow
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Set the number of cards per row to 2
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1,  // Adjust the aspect ratio for 2 cards in a row
              ),
              itemBuilder: (context, index) {
                // List of video URLs for each card
                final videoUrls = [
                  "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/1%20to%2050.mp4?alt=media&token=46e5c5ec-4eb5-436b-9738-4ea2d8f8acaf",
                  "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/reverse%2010%20to%201.mp4?alt=media&token=0f53c3ce-d137-44df-ad75-c6e4a98ed132",
                  "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/inwords1-10.mp4?alt=media&token=70919959-c1fa-4a57-8dc9-7964ebb9c351",
                  "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/before%20after.mp4?alt=media&token=ce2112e4-100d-46d3-968c-94cca7c7d49b",
                  "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/placevalue.mp4?alt=media&token=da9d8e1d-92bc-492f-bf4d-1c9207c76c18",
                ];

                final titles = [
                  'Forward Counting 1-50',
                  'Backward Counting 10-1',
                  'Count in words 1-10',
                  'Before After & In Between',
                  'Place Value',
                ];

                final images = [
                  'assets/img/forward.png',
                  'assets/img/backward.png',
                  'assets/img/inwords.png',
                  'assets/img/callerpillar.png',
                  'assets/img/placevalue.png',
                ];

                return GestureDetector(
                  onTap: () {
                    _showVideoModal(context, videoUrls[index], titles[index]);
                  },
                  child: Card(
                    color: Color(0xFFEF923E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          images[index],
                          width: 150,
                          height: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          titles[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  // Show Video Modal
  void _showVideoModal(BuildContext context, String videoUrl, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 800,
            height: 450,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: VideoPlayerWidget(videoUrl: videoUrl),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEF923E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Video Player Widget (Actual Implementation with Play/Stop)
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isPlaying = false; // Flag to track the play/pause state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
      children: [
        VideoPlayer(_controller),
        Positioned(
          bottom: 20,
          right: 20,
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 50,
              color: Color(0xFFEF923E),
            ),
            onPressed: () {
              setState(() {
                if (isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
                isPlaying = !isPlaying;
              });
            },
          ),
        ),
      ],
    )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
