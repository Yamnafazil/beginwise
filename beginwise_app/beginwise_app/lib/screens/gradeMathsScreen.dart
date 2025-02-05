import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeMathsScreen extends StatefulWidget {
  @override
  _GradeMathsScreenState createState() => _GradeMathsScreenState();
}

class _GradeMathsScreenState extends State<GradeMathsScreen> {
  late List<VideoPlayerController> _controllers;
  late List<Future<void>> _initializeVideoPlayerFutures;
  late List<bool> _isPlaying; // List to track the play/pause state for each video

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _initializeVideoPlayerFutures = [];
    _isPlaying = [];
  }

  void _loadVideo(String videoUrl, int index) {
    // Load video only if not already loaded
    if (_controllers.length <= index) {
      _controllers.add(VideoPlayerController.network(videoUrl));
      _initializeVideoPlayerFutures.add(_controllers[index].initialize());
      _controllers[index].setLooping(true);
      _isPlaying.add(false); // Initial state is paused
    }
  }

  void _togglePlayPause(int index) {
    setState(() {
      if (_isPlaying[index]) {
        _controllers[index].pause();
      } else {
        _controllers[index].play();
      }
      _isPlaying[index] = !_isPlaying[index];
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade-1 Mathematics'),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Heading
            Text(
              'Mathematics',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFFEF923E),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(offset: Offset(2, 2), color: Color(0xFFFFCD3C), blurRadius: 5),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Grid of Video Cards
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // 2 cards per row
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  String videoUrl = '';
                  String image = '';
                  String title = '';

                  switch (index) {
                    case 0:
                      videoUrl = 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/forward%20count%201%20to%20100.mp4?alt=media&token=c44a6473-d77f-41ab-bcd1-ae21fd3d5355';
                      image = 'assets/img/forward.png';
                      title = 'Forward Counting 1-100';
                      break;
                    case 1:
                      videoUrl = 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/reverse%2010%20to%201.mp4?alt=media&token=0f53c3ce-d137-44df-ad75-c6e4a98ed132';
                      image = 'assets/img/backward.png';
                      title = 'Backward Counting 10-1';
                      break;
                    case 2:
                      videoUrl = 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/inwords%201%20to%2020.mp4?alt=media&token=f27b6444-b97e-4f72-aee7-bc35ef317f92';
                      image = 'assets/img/inwords.png';
                      title = 'Count in words 1-20';
                      break;
                    case 3:
                      videoUrl = 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/additon.mp4?alt=media&token=53be6d77-7d21-49fc-9ae0-08a46c354b51';
                      image = 'assets/img/add.png';
                      title = 'Addition';
                      break;
                    case 4:
                      videoUrl = 'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/Substraction.mp4?alt=media&token=b47c04cb-beb5-4bc7-9b60-fd2d4a5835ad';
                      image = 'assets/img/sub.png';
                      title = 'Subtraction';
                      break;
                    case 5:
                      videoUrl = 'https://example.com/video6.mp4';
                      image = 'assets/img/table.png';
                      title = 'Tables';
                      break;
                  }

                  // Load video when card is tapped
                  _loadVideo(videoUrl, index);

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.white,  // Set background to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: 800,
                              height: 450,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: FutureBuilder<void>(
                                        future: _initializeVideoPlayerFutures[index],
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return VideoPlayer(_controllers[index]);
                                          } else if (snapshot.hasError) {
                                            return Center(child: Text('Error loading video'));
                                          } else {
                                            return Center(child: CircularProgressIndicator());
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () => _togglePlayPause(index),
                                        icon: Icon(
                                          _isPlaying[index] ? Icons.pause : Icons.play_arrow,
                                          size: 30,
                                          color: Color(0xFFEF923E),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _controllers[index].pause(); // Pause the video when closing
                                          Navigator.of(context).pop();
                                        },
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
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      color: Color(0xFFEF923E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the text and image
                        children: [
                          Image.asset(image, height: 100),
                          SizedBox(height: 10),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, // Center the text
                          ),
                        ],
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
