import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class LearningSkillsScreen extends StatefulWidget {
  final String? childId;

  LearningSkillsScreen({this.childId});

  @override
  _LearningSkillsScreenState createState() => _LearningSkillsScreenState();
}

class _LearningSkillsScreenState extends State<LearningSkillsScreen> {
  late VideoPlayerController kalmaController;
  late VideoPlayerController colorsController;
  late VideoPlayerController vegetablesController;
  late VideoPlayerController fruitsController;
  late VideoPlayerController countingController;
  late VideoPlayerController shapesController;

  @override
  void initState() {
    super.initState();
    kalmaController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/kalma.mp4?alt=media&token=dd96dc7f-681e-4dc2-9d7b-1633a891169a',
    )..initialize().then((_) => setState(() {}));

    colorsController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/colors.mp4?alt=media&token=a05b4e6f-96d3-48ed-836d-23554e8ef452',
    )..initialize().then((_) => setState(() {}));

    vegetablesController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/Vegetables.mp4?alt=media&token=fd04abac-9436-41b8-9cc8-03362898db12',
    )..initialize().then((_) => setState(() {}));

    fruitsController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/fruits.mp4?alt=media&token=d83dd926-acea-48d7-8245-2691d9deca30',
    )..initialize().then((_) => setState(() {}));

    countingController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/counting1-10.mp4?alt=media&token=a6f5ee9b-f5e9-4e8d-a2e8-4ca3eba5cd4c',
    )..initialize().then((_) => setState(() {}));

    shapesController = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/beginwise-bf56e.appspot.com/o/shapes.mp4?alt=media&token=8a75e6bf-17d8-4019-bd68-7fedaef16210',
    )..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    kalmaController.dispose();
    colorsController.dispose();
    vegetablesController.dispose();
    fruitsController.dispose();
    countingController.dispose();
    shapesController.dispose();
    super.dispose();
  }

  Widget buildSection(String title, VideoPlayerController controller, List<String> instructions) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEF923E),
              ),
            ),
            SizedBox(height: 16.0),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.orange,
                    size: 50,
                  ),
                  onPressed: () {
                    setState(() {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              "Instructions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            ...instructions.map((instruction) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                instruction,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning Skills",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDE8D7), Color(0xFFFAC9A7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  "Let's Embrace the Journey of Learning!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                buildSection(
                  "Kalma Recitation",
                  kalmaController,
                  [
                    "Teach your kids the Pehla Kalma: 'La ilaha illallah, Muhammadur Rasoolullah.'",
                    "Explain the meaning: 'There is no god but Allah, and Muhammad is the Messenger of Allah.'",
                    "Repeat each part after you and practice daily, 5 times in the morning and evening.",
                    "Review daily, especially during prayers or bedtime.",
                  ],
                ),
                buildSection(
                  "Colors Name",
                  colorsController,
                  [
                    "Teach your kids basic colors: Red, Blue, Yellow.",
                    "Use visual aids like pictures, toys, and everyday objects.",
                    "Repeat color names during daily activities (e.g., 'This apple is red').",
                  ],
                ),
                buildSection(
                  "Vegetables Name",
                  vegetablesController,
                  [
                    "Introduce common vegetables: Potato, Tomato, Carrot.",
                    "Use real vegetables for hands-on learning.",
                    "Encourage kids to recognize vegetables during meals or grocery shopping.",
                  ],
                ),
                buildSection(
                  "Fruits Name",
                  fruitsController,
                  [
                    "Teach your kids fruits: Apple, Banana, Orange.",
                    "Use flashcards or show real fruits.",
                    "Encourage kids to name fruits they eat daily.",
                  ],
                ),
                buildSection(
                  "Counting 1-10",
                  countingController,
                  [
                    "Start with numbers 1-10 using fingers.",
                    "Use counting songs or rhymes.",
                    "Encourage counting objects like toys, fruits, or books.",
                  ],
                ),
                buildSection(
                  "Shapes Name",
                  shapesController,
                  [
                    "Introduce basic shapes: Circle, Square, Triangle.",
                    "Use blocks or draw shapes on paper.",
                    "Encourage kids to identify shapes in their surroundings.",
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
