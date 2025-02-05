import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


void main() => runApp(KgReligiousStudiesApp());

class KgReligiousStudiesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Religious Studies',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: KgReligiousStudiesScreen(),
    );
  }
}

class KgReligiousStudiesScreen extends StatefulWidget {
  @override
  _KgReligiousStudiesScreenState createState() =>
      _KgReligiousStudiesScreenState();
}

class _KgReligiousStudiesScreenState extends State<KgReligiousStudiesScreen> {
  FlutterTts flutterTts = FlutterTts();
  int currentQuestion = 0;
  final List<Map<String, String>> questionsWithAnswers = [
    {
      "question": "Who is Allah?",
      "answer": "Allah is our Creator and the One we worship.",
      "image": "https://img.icons8.com/?size=100&id=32btraB1XD1S&format=png&color=000000"
    },
    {
      "question": "What is the name of our religion?",
      "answer": "The name of our religion is Islam.",
      "image": "https://img.icons8.com/?size=100&id=EwqBHhfacGtU&format=png&color=000000"
    },
    {
      "question": "Who is our Prophet?",
      "answer": "Prophet Muhammad (PBUH).",
      "image": "https://img.icons8.com/?size=100&id=3m1aXWBFr7Ek&format=png&color=000000"
    },
    {
      "question": "What is the name of the Holy Book of Muslims?",
      "answer": "The Quran.",
      "image": "https://img.icons8.com/?size=100&id=15281&format=png&color=000000"
    },
    {
      "question": "Where do Muslims go to pray together?",
      "answer": "The mosque (Masjid).",
      "image": "https://img.icons8.com/color/48/000000/mosque.png"
    },
    {
      "question": "How many times do Muslims pray every day?",
      "answer": "Five times.",
      "image": "https://img.icons8.com/?size=100&id=bGrHl9oGbIq3&format=png&color=000000"
    },
    {
      "question": "What is the name of the month when Muslims fast?",
      "answer": "Ramadan.",
      "image": "https://img.icons8.com/?size=100&id=ByljGXZs8hHD&format=png&color=000000"
    },
    {
      "question": "What do Muslims say before eating?",
      "answer": "Bismillah (In the name of Allah).",
      "image": "https://img.icons8.com/?size=100&id=gJ1qhDTvEjDX&format=png&color=000000"
    },
    {
      "question": "What do we say when we greet someone?",
      "answer": "As-salamu alaykum (Peace be upon you).",
      "image": "https://img.icons8.com/?size=100&id=ZlxUPpqohj6O&format=png&color=000000"
    },
    {
      "question": "What do Muslims say after they sneeze?",
      "answer": "Alhamdulillah (All praise is due to Allah).",
      "image": "https://img.icons8.com/color/48/000000/sneeze.png"
    },
    {
      "question": "What do we say when we begin something (like reading or eating)?",
      "answer": "Bismillah (In the name of Allah).",
      "image": "https://img.icons8.com/?size=100&id=5LuL8f0TbOKo&format=png&color=000000"
    },
    {
      "question": "Who was the last Prophet of Islam?",
      "answer": "Prophet Muhammad (PBUH).",
      "image": "https://img.icons8.com/?size=100&id=3m1aXWBFr7Ek&format=png&color=000000"
    },
    {
      "question": "Where was Prophet Muhammad (PBUH) born?",
      "answer": "In Makkah (Mecca).",
      "image": "https://img.icons8.com/?size=100&id=eY8KuEHLc0a9&format=png&color=000000"
    },
    {
      "question": "What do we say when we hear the name of Prophet Muhammad (PBUH)?",
      "answer": "Sallallahu alayhi wa sallam (Peace and blessings be upon him).",
      "image": "https://img.icons8.com/?size=100&id=3m1aXWBFr7Ek&format=png&color=000000"
    },
  ];

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('en-IN'); // Set language to Indian English
    flutterTts.setPitch(3.0); // Neutral pitch
    flutterTts.setSpeechRate(0.5); // Slower rate for clearer pronunciation
  }

  void speakQuestionAndAnswer(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindergarten Religious Studies' ,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Religious Studies',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            SizedBox(height: 10),
            Text(
              'Learn about the basics of Islam through these questions and answers.',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questionsWithAnswers.length,
                itemBuilder: (context, index) {
                  final item = questionsWithAnswers[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.network(
                            item["image"]!,
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["question"]!,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  item["answer"]!,
                                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {
                              speakQuestionAndAnswer(item["question"]! + ' ' + item["answer"]!);
                            },
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
