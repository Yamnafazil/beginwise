import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load the username from SharedPreferences
  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';  // If no username is found, use an empty string
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2E7), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF2E7),
        elevation: 0,
        title: Text(
          username.isEmpty ? 'Hello, User' : 'Hello, $username',
          style: const TextStyle(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, $username! Ready to explore new schools?",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              // Ongoing Course Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0050AC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "PREP HUB",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "One Way Solution For Preperations",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Start Now",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.prepHub);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Continue", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Features Section
              const Text(
                "Features",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FeatureTile(
                    title: "School Finder",
                    icon: Icons.school,
                    color: Colors.orange,
                  ),
                  _FeatureTile(
                    title: "Entrance Exam Preparation",
                    icon: Icons.edit_document,
                    color: Colors.blue,
                  ),
                  _FeatureTile(
                    title: "Parent’s Interview Module",
                    icon: Icons.people,
                    color: Colors.teal,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Column(
                children: [
                  // Banner Image


                  // const SizedBox(height: 20),

                  // Questions Accordion
                  _buildQuestionItem(
                    "1. How do I get started with Beginwise?",
                    "ANSWER: Simply create an account on our platform, set up your child’s profile, and start exploring the various resources and tools we offer.",
                  ),
                  _buildQuestionItem(
                    "2. What age groups and grade levels does Beginwise cater to?",
                    "ANSWER: Beginwise offers educational content and learning modules for children aged 1 to 8, focusing on grade levels from Playgroup to Grade 1.",
                  ),
                  _buildQuestionItem(
                    "3. How does Beginwise recommend schools for my child?",
                    "ANSWER: We use a detailed analysis of your preferences for location, fees, and board to suggest the most suitable schools.",
                  ),
                  _buildQuestionItem(
                    "4. What resources does Beginwise offer for admission test preparation?",
                    "ANSWER: Beginwise provides comprehensive learning modules, practice tests, and interactive quizzes to help your child prepare effectively for admission tests.",
                  ),
                  _buildQuestionItem(
                    "5. Can Beginwise help with parental interview preparation?",
                    "ANSWER: Yes, Beginwise offers guidance and resources to help parents prepare for school interviews, ensuring they present their child’s strengths effectively.",
                  ),
                  _buildQuestionItem(
                    "6. How can I track my child’s progress on Beginwise?",
                    "ANSWER: Beginwise provides detailed progress tracking tools, allowing you to monitor your child’s academic performance and development over time.",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
  Widget _buildQuestionItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable feature tile widget
class _FeatureTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _FeatureTile({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable dropdown field widget
class _DropdownField extends StatelessWidget {
  final String label;

  const _DropdownField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        items: [],
        onChanged: (value) {},
      ),
    );
  }
}
