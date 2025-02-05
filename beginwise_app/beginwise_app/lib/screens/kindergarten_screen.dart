import 'package:flutter/material.dart';
import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class Kindergarten extends StatelessWidget {
  const Kindergarten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2E7),
      appBar: AppBar(
        title: const Text('Kindergarten',
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
          children: [
            Text(
              "Let's Begin the Adventure of Learning and Play!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  SubjectCard(
                    title: 'General Knowledge',
                    imageUrl: 'https://img.icons8.com/?size=100&id=63764&format=png&color=000000',
                    color: Colors.white,
                    route: MyRoutes.kgGeneralKnowledgeScreen,
                  ),
                  SubjectCard(
                    title: 'English',
                    imageUrl: 'https://img.icons8.com/?size=100&id=23427&format=png&color=000000',
                    color: Colors.white,
                    route: MyRoutes.kgEnglishScreen,
                  ),
                  SubjectCard(
                    title: 'Urdu',
                    imageUrl: 'https://img.icons8.com/?size=100&id=9OnqRjP2C3Vo&format=png&color=000000',
                    color: Colors.white,
                    route: MyRoutes.kgUrduScreen,
                  ),
                  SubjectCard(
                    title: 'Religious Studies',
                    imageUrl: 'https://img.icons8.com/?size=100&id=114461&format=png&color=000000',
                    color: Colors.white,
                    route: MyRoutes.kgReligiousStudiesScreen,
                  ),
                  SubjectCard(
                    title: 'Maths',
                    imageUrl: 'https://img.icons8.com/?size=100&id=55206&format=png&color=000000',
                    color: Colors.white,
                    route: MyRoutes.kgMathsScreen,
                  ),
                  SubjectCard(
                    title: 'Quiz',
                    imageUrl: 'https://img.icons8.com/?size=48&id=m8HxOrfIVSiS&format=png',
                    color: Colors.white,
                    route: MyRoutes.kgQuizScreen,
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

  const SubjectCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the subject's content using the route
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 8,
        shadowColor: color.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: color,
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
