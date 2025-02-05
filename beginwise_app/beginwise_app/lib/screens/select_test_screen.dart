import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class SelectTestScreen extends StatelessWidget {
  const SelectTestScreen({Key? key, required this.childId}) : super(key: key);

  final String childId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2E7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF2E7),
        elevation: 0,
        title: const Text(
          'Prephub',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Heading
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Let\'s Start Learning',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Intro Text
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'We recommend starting your child\'s education at the Playgroup level to build a strong foundation. Progressing through the levels ensures a gradual and effective learning experience.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            // Playgroup Button
            LearningLevelButton(
              levelName: 'PlayGroup',
              iconUrl:
              'https://img.icons8.com/?size=256&id=cyxdGajhQVTo&format=png',
              onTap: () {
                // Navigate to Playgroup Screen
                Navigator.pushNamed(context, MyRoutes.playGroup,
                    arguments: childId);
              },
            ),
            // Kindergarten Button
            LearningLevelButton(
              levelName: 'Kindergarten',
              iconUrl:
              'https://img.icons8.com/color/48/000000/abc.png',
              onTap: () {
                // Navigate to Kindergarten Screen
                Navigator.pushNamed(context, MyRoutes.kindergarten,
                    arguments: childId);
              },
            ),
            // Grade 1 Button
            LearningLevelButton(
              levelName: 'Grade-1',
              iconUrl:
              'https://img.icons8.com/color/48/000000/school.png',
              onTap: () {
                // Navigate to Grade 1 Screen
                Navigator.pushNamed(context, MyRoutes.grade1Screen,
                    arguments: childId);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}

class LearningLevelButton extends StatelessWidget {
  final String levelName;
  final String iconUrl;
  final VoidCallback onTap;

  const LearningLevelButton({
    Key? key,
    required this.levelName,
    required this.iconUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Image.network(
              iconUrl,
              width: 40,
              height: 40,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, size: 40, color: Colors.red),
            ),
            const SizedBox(width: 20),
            // Level Name
            Text(
              levelName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
