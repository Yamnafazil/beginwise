import 'package:beginwise/widgets/my_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class InterviewQuestionsScreen extends StatelessWidget {
  const InterviewQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigation(),
      backgroundColor: const Color(0xFFFFF2E7), // Background color
      appBar: AppBar(
        backgroundColor:  Colors.orange,
        elevation: 0,
        title: const Text(
          'Interview Questions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Image


            // const SizedBox(height: 20),

            // Questions Accordion
            _buildQuestionItem(
              "1. Can you tell us about your child's strengths and weaknesses?",
              "ANSWER: My child demonstrates strengths in [specific areas such as problem-solving, creativity, communication, etc.]. However, like any individual, they also have areas where they may need additional support or improvement, such as [mention specific weaknesses].",
            ),
            _buildQuestionItem(
              "2. What do you think sets your child apart from others?",
              "ANSWER: What sets my child apart is their [unique qualities, talents, or interests]. They excel in [mention specific activities or subjects], and their passion and dedication make them stand out among their peers.",
            ),
            _buildQuestionItem(
              "3. How does your child handle challenges or setbacks?",
              "ANSWER: My child approaches challenges and setbacks with resilience and determination. They view obstacles as opportunities for growth, and they're not afraid to seek help or try different strategies until they find a solution.",
            ),
            _buildQuestionItem(
              "4. What are your expectations from our institution for your child's education and development?",
              "ANSWER: Outside of school, I plan to support my child's learning by [mention specific activities or resources, such as visiting museums, enrolling in extracurricular classes, encouraging reading, etc.].",
            ),
            _buildQuestionItem(
              "5. Can you share any specific instances where you've seen your child demonstrate leadership or teamwork skills?",
              "ANSWER: I've seen my child demonstrate leadership and teamwork skills during [mention specific instances, such as group projects, sports teams, community service activities, etc.]. They have a natural ability to [describe leadership qualities or teamwork behaviors].",
            ),
            _buildQuestionItem(
              "6. How do you plan to support your child's learning outside of school?",
              "ANSWER: I've seen my child demonstrate leadership and teamwork skills during [mention specific instances, such as group projects, sports teams, community service activities, etc.]. They have a natural ability to [describe leadership qualities or teamwork behaviors].",
            ),
            _buildQuestionItem(
              "7. How do you envision your child contributing to our school community?",
              "ANSWER: I envision my child contributing to the school community by [mention specific ways, such as participating in clubs or organizations, volunteering, mentoring younger students, etc.]. They are eager to make a positive impact and actively engage with their peers and teachers.",
            ),
            _buildQuestionItem(
              "8. What values and principles are important to your family, and how do you instill them in your child?",
              "ANSWER: In our family, values such as [mention specific values, such as honesty, kindness, perseverance, etc.] are important. We instill these values in our child through [describe how you model and teach these values in everyday life].",
            ),
            _buildQuestionItem(
              "9. How do you handle discipline and behavior management at home?",
              "ANSWER: We believe in using positive reinforcement, clear communication, and consistent consequences to manage behavior at home. We also encourage open dialogue and problem-solving to address any issues that may arise.",
            ),
            _buildQuestionItem(
              "10. Are there any particular extracurricular activities or interests your child is passionate about?",
              "ANSWER: My child is passionate about [mention specific extracurricular activities or interests, such as sports, music, art, etc.]. These activities allow them to explore their talents and develop new skills outside of academics.",
            ),
          ],
        ),
      ),
    );
  }

  // Function to create each accordion item (Question + Answer)
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
