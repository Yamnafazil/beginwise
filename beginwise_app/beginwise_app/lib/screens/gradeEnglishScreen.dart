import 'package:flutter/material.dart';
import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class GradeEnglishScreen extends StatelessWidget {
  // List of subjects and their respective links
  final List<Map<String, String>> subjects = [
    {
      'image': 'assets/img/13.png',
      'title': 'Nouns Pronouns Adjectives',
      'link': MyRoutes.gradeNounsPronounsScreen,
    },
    {
      'image': 'assets/img/14.png',
      'title': 'These Those There are',
      'link': MyRoutes.gradeTheseThoseScreen,
    },
    {
      'image': 'assets/img/16.png',
      'title': 'Wh Ch Sh words',
      'link': MyRoutes.gradeWhChShScreen,
    },
    {
      'image': 'assets/img/10.png',
      'title': 'Word Opposites',
      'link': MyRoutes.gradeWordOppositesScreen,
    },
    {
      'image': 'assets/img/17.png',
      'title': 'Make Sentences',
      'link': MyRoutes.gradeMakeSentencesScreen,
    },
    {
      'image': 'assets/img/15.png',
      'title': 'Essay Writing',
      'link': MyRoutes.gradeEssayWritingScreen,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grade-1 English',
        ),
        backgroundColor: Color(0xFFEF923E),
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore English Topics',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final item = subjects[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, item['link']!);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFEF923E), Color(0xFFFFCD3C)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                item['title']!,
                                textAlign: TextAlign.center, // Text justified
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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
