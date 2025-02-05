import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class SpeakingSkillsScreen extends StatefulWidget {
  final String childId;

  SpeakingSkillsScreen({required this.childId});

  @override
  _SpeakingSkillsScreenState createState() => _SpeakingSkillsScreenState();
}

class _SpeakingSkillsScreenState extends State<SpeakingSkillsScreen> {
  late FlutterTts _flutterTts;  // Declare FlutterTts instance

  List<String> pages = [
    'img',
    'speaking',
    'listening',
    'learning',
    'recognition',
    'motor',
    'playgroup_quiz'
  ];

  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();  // Initialize flutter_tts instance
  }

  // Function to speak the question
  void speakQuestion(String question) async {
    await _flutterTts.speak(question);
  }

  @override
  Widget build(BuildContext context) {
    String prevPage = currentIndex > 0 ? pages[currentIndex - 1] : '';
    String nextPage = currentIndex < pages.length - 1 ? pages[currentIndex + 1] : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Speaking Skills',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Boost Confidence and Communication Together, Master Communication, One Question at a Time!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              'Teaching kids speech and communication skills involves creating an engaging and supportive environment. Here are some effective strategies:',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (int i = 0; i < 10; i++) _buildQuestionCard(i),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget _buildQuestionCard(int index) {
    List<Map<String, String>> questions = [
      {'question': 'What is your name?', 'imageUrl': 'https://img.icons8.com/?size=256&id=IBgUXg3MQlTW&format=png'},
      {'question': 'What is your father\'s name?', 'imageUrl': 'https://img.icons8.com/?size=256&id=Q9IrrC9g1sRO&format=png'},
      {'question': 'What is your mother\'s name?', 'imageUrl': 'https://img.icons8.com/?size=256&id=oSU5OJ7VszaM&format=png'},
      {'question': 'How many siblings do you have?', 'imageUrl': 'https://img.icons8.com/?size=256&id=emPS8AqkPO3n&format=png'},
      {'question': 'Where do you live?', 'imageUrl': 'https://img.icons8.com/?size=256&id=wFfu6zXx15Yk&format=png'},
      {'question': 'What is your city name?', 'imageUrl': 'https://img.icons8.com/?size=256&id=4b6WRFTFxoFX&format=png'},
      {'question': 'What is your country name?', 'imageUrl': 'https://img.icons8.com/?size=256&id=Zoa7KPc15kRY&format=png'},
      {'question': 'What is your religion?', 'imageUrl': 'https://img.icons8.com/?size=256&id=f0LmcVCZTqfE&format=png'},
      {'question': 'What is your favorite color?', 'imageUrl': 'https://img.icons8.com/?size=256&id=59484&format=png'},
      {'question': 'Do you know the phone number of your father or mother?', 'imageUrl': 'https://img.icons8.com/?size=256&id=113803&format=png'},
      {'question': 'What is your favorite food?', 'imageUrl': 'https://img.icons8.com/?size=256&id=0Gi7r8YcXKVU&format=png'}
    ];

    var question = questions[index];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(question['question']!, style: TextStyle(fontSize: 18)),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(question['imageUrl']!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () => speakQuestion(question['question']!),
          ),
        ],
      ),
    );
  }

  void navigateToPage(String page) {
    Navigator.pushReplacementNamed(context, '/$page', arguments: widget.childId);
  }
}
