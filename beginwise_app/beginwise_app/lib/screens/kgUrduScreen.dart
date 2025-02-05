import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class KgUrduScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Urdu Learning',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Learn Urdu',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFFEF923E),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(3, 3),
                    color: Color(0xFFFFCD3C),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Alphabets, Numbers, Fruits, Vegetables, Animals & More',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2, // Adjust this for better fitting
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),

    );
  }

  Widget _buildCard(BuildContext context, int index) {
    List<Map<String, String>> items = [
      {
        "image": "assets/img/alifbay.png",
        "title": "حرف تہجی",
        "videoUrl": "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/alifbay.mp4?alt=media&token=b9d0e0c2-36e5-4ad5-a8bb-0cbf6ba9d75c"
      },
      {
        "image": "assets/img/colors.png",
        "title": "رنگوں کے نام",
        "videoUrl": "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/rangoknaam.mp4?alt=media&token=175d0b67-c3a8-4cce-992b-d0673c69f883"
      },
      {
        "image": "assets/img/urdu_fruits.png",
        "title": "پھلوں کے نام",
        "videoUrl": "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/phaloknaam.mp4?alt=media&token=1775a37a-885d-43a8-a0dd-db0251f475b6"
      },
      {
        "image": "assets/img/urdu_veg.png",
        "title": "سبزیوں کے نام",
        "videoUrl": "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/sabzioknaam.mp4?alt=media&token=a75ade5c-b052-433a-bf89-043da0ec2c3a"
      },
      {
        "image": "assets/img/urdu_animal.png",
        "title": "جانور کے نام",
        "videoUrl": "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/janwaroknaam.mp4?alt=media&token=e281e6da-b88d-4a38-aa11-406984acfcf0"
      },
      {
        "image": "assets/img/ginti.png",
        "title": "گنتی",
        "videoUrl": "https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/ginti.mp4?alt=media&token=45bfdca7-6946-4445-8464-58580392e518"
      },
    ];

    return GestureDetector(
      onTap: () => _showVideoModal(context, items[index]['videoUrl']!),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEF923E), Color(0xFFFFCD3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                items[index]['image']!,
                width: 120,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                items[index]['title']!,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVideoModal(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                color: Color(0xFFEF923E),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Video',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayerWidget(url: videoUrl),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  VideoPlayerWidget({required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 50,
                color: Colors.white,
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
        ),
      ],
    )
        : Center(child: CircularProgressIndicator());
  }
}
