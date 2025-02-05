import 'dart:convert';
import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class ShowProgressScreen extends StatefulWidget {
  const ShowProgressScreen({super.key});

  @override
  _ShowProgressScreenState createState() => _ShowProgressScreenState();
}

class _ShowProgressScreenState extends State<ShowProgressScreen> {
  late int childId;
  bool isLoading = true;
  Map<String, dynamic> childData = {};
  List<dynamic> quizProgress = [];

  @override
  void initState() {
    super.initState();
    _fetchChildId();
  }

  Future<void> _fetchChildId() async {
    final prefs = await SharedPreferences.getInstance();
    childId = prefs.getInt('lastSelectedChildId') ?? 0;
    if (childId != 0) {
      _fetchChildDetails();
    } else {
      print('Child ID not found in SharedPreferences');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchChildDetails() async {
    final Uri childDetailsUrl = Uri.parse('http://192.168.1.109:5000/api/child/show-child-by-child-id/$childId');
    final Uri quizResultsUrl = Uri.parse('http://192.168.1.109:5000/api/quiz-result/results/$childId');

    try {
      final childResponse = await http.get(childDetailsUrl);
      final quizResponse = await http.get(quizResultsUrl);

      final childDetails = json.decode(childResponse.body);
      final quizDetails = json.decode(quizResponse.body);

      if (childDetails['data'] != null) {
        setState(() {
          childData = childDetails['data'][0];
        });
      }

      if (quizDetails['data'] != null && quizDetails['data'].isNotEmpty) {
        setState(() {
          quizProgress = quizDetails['data'];
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, MyRoutes.childrens);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Child Progress',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Use the accent color for the app bar title
            ),),
          backgroundColor: const Color(0xFFEF923E),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, MyRoutes.childrens);
            },
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFFEF923E)))
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            childData['GENDER'] == 'Male'
                                ? 'assets/img/male.png'
                                : 'assets/img/female.png',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                childData['CHILD_NAME'] ?? 'Child\'s Name',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/selectTest', arguments: childId);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEF923E),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Start Learning'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Quiz Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 10),
                quizProgress.isEmpty
                    ? const Center(child: Text('No quiz progress available for this child.'))
                    : Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(const Color(0xFFEF923E).withOpacity(0.1)),
                      columns: const [
                        DataColumn(label: Text('Grade Level')),
                        DataColumn(label: Text('Score')),
                        DataColumn(label: Text('Total Questions')),
                        DataColumn(label: Text('Date Completed')),
                        DataColumn(label: Text('Progress')),
                      ],
                      rows: quizProgress.map<DataRow>((progress) {
                        final int score = progress['score'] ?? 0;
                        final int totalQuestions = progress['total_questions'] ?? 1;
                        final int scorePercentage = totalQuestions > 0
                            ? ((score / totalQuestions) * 100).round()
                            : 0;

                        return DataRow(
                          cells: [
                            DataCell(Text(progress['grade_level']?.toString() ?? 'N/A')),
                            DataCell(Text(score.toString())),
                            DataCell(Text(totalQuestions.toString())),
                            DataCell(Text(progress['completed_at'] != null
                                ? DateTime.parse(progress['completed_at']).toLocal().toString()
                                : 'N/A')),
                            DataCell(
                              SizedBox(
                                width: 100,
                                child: LinearProgressIndicator(
                                  value: scorePercentage / 100,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFFEF923E),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigation(),
      ),
    );
  }
}
