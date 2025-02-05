import 'package:flutter/material.dart';
import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class KgEnglishScreen extends StatelessWidget {
  // List of subjects and their respective links for KG (Kindergarten) English
  final List<Map<String, String>> subjects = [
    {
      'image': 'assets/img/capitalsmall.png',
      'title': 'Capital and Small Letters',
      'link': MyRoutes.kgCapitalSmallLetterScreen,
    },
    {
      'image': 'assets/img/sgr.png',
      'title': 'Sky Grass Root Letters',
      'link': MyRoutes.kgSkyGrassRootLetters,
    },
    {
      'image': 'assets/img/vowels.png',
      'title': 'Vowels and Consonants',
      'link': MyRoutes.kgVowelsConsonents,
    },
    {
      'image': 'assets/img/This.png',
      'title': 'This and That',
      'link': MyRoutes.kgThisThat,
    },
    {
      'image': 'assets/img/singplu.png',
      'title': 'Singular and Plural',
      'link': MyRoutes.kgSingularPlural,
    },
    {
      'image': 'assets/img/recognize.png',
      'title': 'Recognition',
      'link': MyRoutes.kgRecognition,
    },
    {
      'image': 'assets/img/missing.png',
      'title': 'Missing Words',
      'link': MyRoutes.kgMissingWords,
    },
    {
      'image': 'assets/img/masculinefeminine.png',
      'title': 'Masculine and Feminine',
      'link': MyRoutes.kgMasculineFeminine,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kindergarten English',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),
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
              'Explore KG English Topics',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black, // Use the accent color for headings
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
                      // Navigate to the corresponding screen
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
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // Center the text for better layout
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
