import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class PlayGroupScreen extends StatelessWidget {
  final String childId;
  PlayGroupScreen({required this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2E7),
      appBar: AppBar(
        title: const Text('Playgroup',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's Begin the Adventure of Learning and Play!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  SubjectCard(
                    title: 'Speaking',
                    imageUrl: 'https://img.icons8.com/color/96/000000/microphone.png',
                    color: Colors.white,
                    route: MyRoutes.speakingSkillsScreen,
                    childId: childId,
                  ),
                  SubjectCard(
                    title: 'Listening',
                    imageUrl: 'https://img.icons8.com/color/96/000000/headphones.png',
                    color: Colors.white,
                    route: MyRoutes.listeningSkillsScreen,
                    childId: childId,
                  ),
                  SubjectCard(
                    title: 'Learning',
                    imageUrl: 'https://img.icons8.com/color/96/000000/open-book.png',
                    color: Colors.white,
                    route: MyRoutes.learningSkillsScreen,
                    childId: childId,
                  ),
                  SubjectCard(
                    title: 'Recognition',
                    imageUrl: 'https://img.icons8.com/?size=256&id=109685&format=png',
                    color: Colors.white,
                    route: MyRoutes.recognition,
                    childId: childId,
                  ),
                  SubjectCard(
                    title: 'Motor Skills',
                    imageUrl: 'https://img.icons8.com/color/96/000000/hand.png',
                    color: Colors.white,
                    route: MyRoutes.motorSkillsScreen,
                    childId: childId,
                  ),
                  SubjectCard(
                    title: 'Quiz',
                    imageUrl: 'https://img.icons8.com/?size=48&id=m8HxOrfIVSiS&format=png',
                    color: Colors.white,
                    route: MyRoutes.quizSkillsScreen,
                    childId: childId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color color;
  final String route;
  final String childId;

  const SubjectCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.route,
    required this.childId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: color.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: color,
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 64,
              width: 64,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error,
                  size: 64,
                  color: Colors.red,
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Color.fromARGB(64, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
