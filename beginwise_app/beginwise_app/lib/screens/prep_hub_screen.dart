import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';
import 'package:flutter/material.dart';

class PrepHubScreen extends StatelessWidget {
  const PrepHubScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigation(),
      backgroundColor:  Color(0xFFFFF2E7),
      appBar: AppBar(
      backgroundColor: Colors.orange,
        elevation: 0,
        title: Text('Prephub',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),
        ),
        centerTitle: false,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Heading
              Text(
                'Interview & Admission Prep',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Subheading
              Text(
                'Explore our dedicated resources for both interview preparation and admission test readiness.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 32),

              // Admission Test Heading
              Text(
                'Admission Test Preparation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Admission Test Subheading
              Text(
                'Prepare for your admission test with BeginWise\'s comprehensive resources. Access practice tests, interactive study materials, and personalized learning plans tailored to your needs. Manage exam stress with our mental wellness resources and connect with peers for support. Get ready to excel with BeginWise.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),

              // Button for Admission Test Navigation
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.childrens);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),                child: Text('Explore Admission Test Prep', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 32),

              // Interview Prep Heading
              Text(
                'Interview Preparation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Interview Prep Subheading
              Text(
                'BeginWise provides a streamlined interview preparation module for parents, offering essential resources such as communication tips, practice questions, and strategies to effectively showcase their child\'s strengths and interests during school admissions interviews. This module equips parents with the confidence and tools necessary to navigate these crucial interactions with school authorities, increasing their child\'s chances of securing admission to their preferred schools.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),

              // Button for Interview Preparation Navigation
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.interviewQuestions);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Explore Interview Prep' , style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
