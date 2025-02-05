import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class MotorSkillsScreen extends StatefulWidget {
  final String childId;

  const MotorSkillsScreen({Key? key, required this.childId}) : super(key: key);

  @override
  _MotorSkillsScreenState createState() => _MotorSkillsScreenState();
}

class _MotorSkillsScreenState extends State<MotorSkillsScreen> {
  List<dynamic> worksheets = [];
  final Color primaryColor = const Color(0xFFEF923E);

  @override
  void initState() {
    super.initState();
    _fetchWorksheets();
  }

  Future<void> _fetchWorksheets() async {
    try {
      final response =
      await http.get(Uri.parse('http://192.168.1.109:5000/api/worksheet/get/grade/1'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          worksheets = data['data'];
        });
      } else {
        setState(() {
          worksheets = [];
        });
      }
    } catch (error) {
      print('Error fetching worksheets: $error');
      setState(() {
        worksheets = [];
      });
    }
  }

  void _showImageFullScreen(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final childId = widget.childId;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Motor Skills Worksheets',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: worksheets.isNotEmpty
                  ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: worksheets.length,
                itemBuilder: (context, index) {
                  final worksheet = worksheets[index];
                  final imageUrl =
                      'http://192.168.1.109:5000/${worksheet['image_path']}';

                  return GestureDetector(
                    onTap: () {
                      _showImageFullScreen(context, imageUrl);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, size: 50, color: Colors.red),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              worksheet['title'] ?? 'No Title',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : const Center(
                child: Text(
                  'No Worksheets Found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchWorksheets,
        backgroundColor: primaryColor,
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
