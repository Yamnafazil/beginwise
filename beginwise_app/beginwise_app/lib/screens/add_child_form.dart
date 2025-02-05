import 'dart:convert';
import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';


class AddChildForm extends StatefulWidget {
  const AddChildForm({Key? key}) : super(key: key);

  @override
  State<AddChildForm> createState() => _AddChildFormState();
}

class _AddChildFormState extends State<AddChildForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _childNameController = TextEditingController();
  String? _selectedGrade;
  String? _selectedGender;
  String? _parentId;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  List<Map<String, String>> _grades = [];
  int? _currentChildCount;

  @override
  void initState() {
    super.initState();
    _fetchGrades();
    _getParentId();
    _getCurrentChildCount();
  }

  @override
  void dispose() {
    _dobController.dispose();
    _childNameController.dispose();
    super.dispose();
  }

  Future<void> _fetchGrades() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.109:5000/api/grade/all'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _grades = (data['data'] as List)
              .map((grade) => {
            'ID': grade['ID'].toString(),
            'GRADE_LEVEL': grade['GRADE_LEVEL'].toString(),
          })
              .toList();
        });
      } else {
        throw Exception('Failed to fetch grades');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching grades: $e')),
      );
    }
  }

  Future<void> _getParentId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _parentId = prefs.getString('userId');
    });
  }

  Future<void> _getCurrentChildCount() async {
    if (_parentId != null) {
      try {
        final response = await http.get(Uri.parse('http://192.168.109:5000/api/child/parent-child-count/$_parentId'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _currentChildCount = data['childCount'];
          });
        } else {
          throw Exception('Failed to fetch child count');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching child count: $e')),
        );
      }
    }
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = '${pickedDate.toLocal()}'.split(' ')[0]; // Format as YYYY-MM-DD
      });
    }
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_currentChildCount != null && _currentChildCount! >= 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can only register up to 3 children')),
        );
        return;
      }

      final dob = _dobController.text;
      final childName = _childNameController.text;
      final gradeId = _grades.firstWhere((grade) => grade['GRADE_LEVEL'] == _selectedGrade)['ID'];
      final gender = _selectedGender;

      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.1090:5000/api/child/register-child'),
          body: jsonEncode({
            'parent_id': _parentId,
            'd_o_b': dob,
            'c_name': childName,
            'g_level': gradeId,
            'gender': gender,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Child added successfully!')),
          );
          Navigator.pushNamed(context, MyRoutes.childrens);
        } else {
          throw Exception('Failed to add child');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding child: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2E7),
      appBar: AppBar(
        title: const Text('Add Child Details',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: const Color(0xFFEF923E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _selectDateOfBirth(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth (YYYY-MM-DD)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFFEF923E)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Date of Birth';
                        }
                        DateTime dob = DateTime.parse(value);
                        if (DateTime.now().difference(dob).inDays < 365 * 2) {
                          return 'Child must be at least 2 years old';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _childNameController,
                  decoration: InputDecoration(
                    labelText: 'Child Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.person, color: Color(0xFFEF923E)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Child Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedGrade,
                  decoration: InputDecoration(
                    labelText: 'Grade Level',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  items: _grades
                      .map((grade) => DropdownMenuItem<String>(
                    value: grade['GRADE_LEVEL']!,
                    child: Text(grade['GRADE_LEVEL']!),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGrade = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Grade Level';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  items: _genderOptions
                      .map((gender) => DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xFFEF923E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: submitForm,
                  child: const Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),

    );
  }
}
