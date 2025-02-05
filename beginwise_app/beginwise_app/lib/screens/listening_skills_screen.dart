import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class ListeningSkillsScreen extends StatefulWidget {
  final String childId;
  ListeningSkillsScreen({required this.childId});

  @override
  _ListeningSkillsScreenState createState() => _ListeningSkillsScreenState();
}

class _ListeningSkillsScreenState extends State<ListeningSkillsScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _isVideoPlaying = false;  // Track video state (playing or stopped)
  FlutterTts _flutterTts = FlutterTts();  // Initialize TTS
  int currentInstruction = 0;

  List<Map<String, String>> instructions = [
    {"text": "Stand up", "animation": "assets/standup.gif"},
    {"text": "Sit down", "animation": "assets/sitdown.gif"},
    {"text": "Clap", "animation": "assets/clap.gif"},
    {"text": "Jump", "animation": "assets/jump.gif"},
    {"text": "Open the door", "animation": "assets/open_the_door.gif"},
    {"text": "Close the door", "animation": "assets/close_the_door.gif"},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the video player to load video from assets
    _controller = VideoPlayerController.asset('assets/commands.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        // The video will not play automatically after initialization
        print("Video Initialized Successfully");
      }).catchError((error) {
        print("Error initializing video: $error");
      });

    // Set language for TTS
    _flutterTts.setLanguage("en-US");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _flutterTts.stop();
  }

  // Function to speak the instruction
  void _speakInstruction(String text) {
    _flutterTts.speak(text);
  }

  // Function to navigate to next instruction
  void _nextInstruction() {
    if (currentInstruction < instructions.length - 1) {
      setState(() {
        currentInstruction++;
      });
    } else {
      setState(() {
        currentInstruction = 0;  // Reset to the first instruction
      });
    }
    _speakInstruction(instructions[currentInstruction]['text']!);
  }

  // Function to navigate to previous instruction
  void _previousInstruction() {
    if (currentInstruction > 0) {
      setState(() {
        currentInstruction--;
      });
    }
    _speakInstruction(instructions[currentInstruction]['text']!);
  }

  // Function to play video
  void _playVideo() {
    if (!_isVideoPlaying) {
      _controller.play();
      setState(() {
        _isVideoPlaying = true;
      });
    }
  }

  // Function to stop video
  void _stopVideo() {
    if (_isVideoPlaying) {
      _controller.pause();
      setState(() {
        _isVideoPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Skills',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Heading
              Text(
                'Listening Skills',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEF923E),
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color(0xFFFFCD3C),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Video Player
              if (_isVideoInitialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              else
                CircularProgressIndicator(),

              SizedBox(height: 20),

              // Video Play/Stop Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _playVideo,
                    child: Text('Play Video'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF923E), // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _stopVideo,
                    child: Text('Stop Video'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF923E), // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Instruction List
              Text(
                'Instructions:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _instructionList(),

              SizedBox(height: 40),

              // GIF and Controls
              Image.asset(
                instructions[currentInstruction]['animation']!,
                width: 200, // Adjust size as needed
                height: 200, // Adjust size as needed
                fit: BoxFit.cover, // Adjust the fit
              ),
              SizedBox(height: 20),

              // Navigation Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: _previousInstruction,
                    iconSize: 36,
                    color: Color(0xFFEF923E),
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () => _speakInstruction(instructions[currentInstruction]['text']!),
                    iconSize: 36,
                    color: Color(0xFFEF923E),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: _nextInstruction,
                    iconSize: 36,
                    color: Color(0xFFEF923E),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  // Instruction list displayed
  Widget _instructionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. Start by getting their attention and ensuring they are focused on you.'),
        Text('2. Clearly say each instruction, demonstrating the action yourself.'),
        Text('3. Use a calm and cheerful tone to make it engaging.'),
        Text('4. After demonstrating, ask them to repeat the actions.'),
        Text('5. Practice regularly with games like Simon Says to reinforce their listening skills.'),
        Text('6. Praise them when they follow instructions correctly to encourage their efforts.'),
      ],
    );
  }
}
