import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class Gradequizscreen extends StatefulWidget {
  const Gradequizscreen({Key? key}) : super(key: key);

  @override
  _GradequizscreenState createState() => _GradequizscreenState();
}

class _GradequizscreenState extends State<Gradequizscreen> {
  List<dynamic> quizQuestions = [];
  bool isLoading = true;
  Map<String, String> selectedOptions = {};
  late int childId;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  Future<void> _initializeQuiz() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    childId = prefs.getInt('lastSelectedChildId') ?? 0; // Get child ID from shared preferences
    if (childId != 0) {
      _fetchQuizData();
    } else {
      print("Child ID not found");
      setState(() => isLoading = false);
    }
  }

  Future<void> _fetchQuizData() async {
    var url = Uri.parse('http://192.168.1.109:5000/api/quiz/all/grade/3');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          quizQuestions = jsonDecode(response.body)['data'] ?? [];
          isLoading = false;
        });
      } else {
        print('Failed to load quiz data. Status Code: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching quiz data: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitQuiz() async {
    var url = Uri.parse('http://192.168.1.109:5000/api/quiz-result/results');
    int score = selectedOptions.entries
        .where((entry) => quizQuestions.any(
            (q) => q['id'].toString() == entry.key && q['correct_option'] == entry.value))
        .length;

    Map<String, dynamic> results = {
      'child_id': childId,
      'grade_level': 'playgroup',
      'score': score,
      'total_questions': quizQuestions.length,
      'answers': selectedOptions
    };
    print(results);

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(results),
      );

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        if (responseData['message'] == 'Quiz result added successfully') {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Quiz Submitted Successfully'),
              content: Text('You scored $score/${quizQuestions.length}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, MyRoutes.showProgress),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          print('API Error: ${responseData['error']}');
          _showErrorDialog('Failed to submit quiz results.');
        }
      } else {
        print('Failed to submit quiz results. Status Code: ${response.statusCode}');
        _showErrorDialog('Failed to submit quiz results.');
      }
    } catch (e) {
      print('Error submitting quiz results: $e');
      _showErrorDialog('Error submitting quiz results.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade-1 Quiz'),
        backgroundColor: const Color(0xFFEF923E),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: quizQuestions.length,
        itemBuilder: (context, index) {
          final question = quizQuestions[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question['question'] ?? 'No question',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  if (question['question_image'] != null)
                    Image.network(
                      'http://192.168.1.109:5000/${question['question_image']}',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 10),
                  Center( // Wrap the Wrap widget with Center to center-align options
                    child: Wrap(
                      spacing: 10,
                      children: ['a', 'b', 'c', 'd'].map((option) {
                        final optionKey = 'option_${option}_image';
                        final imageUrl =
                            'http://192.168.1.109:5000/${question[optionKey]}';
                        final isSelected =
                            selectedOptions[question['id'].toString()] == option.toUpperCase();
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptions[question['id'].toString()] = option.toUpperCase();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFF6B84E)
                                    : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageUrl,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitQuiz,
        backgroundColor: const Color(0xFFEF923E),
        child: const Icon(Icons.check),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
