import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:beginwise/my_routes.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({super.key});

  @override
  _ChildrenScreenState createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  bool isLoggedIn = false;
  List<dynamic> childrenList = [];
  bool isLoading = false;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _storeChildId(int childId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastSelectedChildId', childId);
    print('Stored child ID: ${prefs.getInt('lastSelectedChildId')}');
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    setState(() {
      isLoggedIn = userId.isNotEmpty;
    });

    if (isLoggedIn) {
      _fetchChildrenData();
    }
  }

  Future<void> _fetchChildrenData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.109:5000/api/child/show-child-by-parent/$userId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          childrenList = data['data'];
        });
      } else if (response.statusCode == 404) {
        setState(() {
          childrenList = [];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching children data: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _addChild() {
    Navigator.pushNamed(context, MyRoutes.addUser);
  }

  Future<void> _deleteChild(int childId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.109:5000/api/child/delete/$childId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          childrenList.removeWhere((child) => child['ID'] == childId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Child deleted successfully')),
        );
      } else {
        throw Exception('Failed to delete child');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting child: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      bottomNavigationBar: const MyBottomNavigation(),
      appBar: AppBar(
        title: const Text('Children', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFEF923E),
        elevation: 4,
      ),
      body: isLoggedIn
          ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFEF923E),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _addChild,
              child: const Text('Add Child', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : childrenList.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "No children found. Please add a child.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              itemCount: childrenList.length,
              itemBuilder: (context, index) {
                final child = childrenList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              child['GENDER'] == "Male" ? Icons.boy : Icons.girl,
                              color: const Color(0xFFEF923E),
                              size: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                child['CHILD_NAME'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Grade: ${child['GRADE_LEVEL']}',
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          'DOB: ${child['D_O_B']}',
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          'Gender: ${child['GENDER']}',
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _storeChildId(int.parse(child['ID'].toString()));
                                  Navigator.pushNamed(
                                    context,
                                    MyRoutes.selectTest,
                                    arguments: int.parse(child['ID'].toString()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEF923E),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Start Learning"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _storeChildId(int.parse(child['ID'].toString()));
                                  Navigator.pushNamed(
                                    context,
                                    MyRoutes.showProgress,
                                    arguments: int.parse(child['ID'].toString()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEF923E),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Show Progress"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Please login or signup to see your child's information.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.profile);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFFEF923E),
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Login or Signup", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
