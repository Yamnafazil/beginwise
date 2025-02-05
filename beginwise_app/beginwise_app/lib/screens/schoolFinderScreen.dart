import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class SchoolFinderScreen extends StatefulWidget {
  @override
  _SchoolSearchScreenState createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolFinderScreen> {
  List<String> _addresses = [];
  List<String> _boards = [];
  List<String> _selectedAddresses = [];
  List<String> _selectedBoards = [];
  String? _selectedFee;
  List<String> _fees = [];

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
    _fetchBoards();
    _fetchFees();
  }

  void _fetchAddresses() async {
    final response = await http.get(Uri.parse('http://192.168.1.109:5000/api/school/addresses'));
    if (response.statusCode == 200) {
      setState(() {
        _addresses = List<String>.from(json.decode(response.body));
      });
    }
  }

  void _fetchBoards() async {
    final response = await http.get(Uri.parse('http://192.168.1.109:5000/api/school/boards'));
    if (response.statusCode == 200) {
      setState(() {
        _boards = List<String>.from(json.decode(response.body));
      });
    }
  }

  void _fetchFees() async {
    final response = await http.get(Uri.parse('http://192.168.1.109:5000/api/school/fees'));
    if (response.statusCode == 200) {
      setState(() {
        _fees = List<String>.from(json.decode(response.body));
      });
    }
  }

  void _submitForm() async {
    if (_selectedAddresses.isEmpty || _selectedBoards.isEmpty || _selectedFee == null) {
      _showAlert('Please ensure you have selected at least one address, one board, and a fee range.');
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.1.109:5000/api/school/search-schools'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'addresses': _selectedAddresses,
        'fees': _selectedFee,
        'boards': _selectedBoards,
      }),
    );

    if (response.statusCode == 404) {
      _showAlert('No schools found matching your criteria.');
    } else if (response.statusCode == 200) {
      List schools = json.decode(response.body);

      List matched3 = schools.where((school) => school['matched'] == 3).toList();
      List matched2 = schools.where((school) => school['matched'] == 2).take(5).toList();
      List matched1 = schools.where((school) => school['matched'] == 1).take(3).toList();

      List sortedAndFilteredSchools = [...matched3, ...matched2, ...matched1];

      _displayResults(sortedAndFilteredSchools);
    } else {
      _showAlert('Failed to load data. Please try again.');
    }
  }

  void _displayResults(List schools) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(schools: schools),
      ),
    );
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAddressSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF4E3), Color(0xFFFFFFFF)], // Light orange gradient
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Addresses (max 3)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEF923E), // Orange text
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _addresses.length,
                    itemBuilder: (context, index) {
                      final address = _addresses[index];
                      final isSelected = _selectedAddresses.contains(address);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 2.0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            setState(() {
                              if (!isSelected && _selectedAddresses.length < 3) {
                                _selectedAddresses.add(address);
                              } else if (isSelected) {
                                _selectedAddresses.remove(address);
                              } else {
                                _showAlert('You can select up to 3 addresses.');
                              }
                            });
                          },
                          child: CheckboxListTile(
                            value: isSelected,
                            title: Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.0),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Color(0xFFEF923E), // Orange active checkbox color
                            onChanged: (isChecked) {
                              setState(() {
                                if (isChecked == true &&
                                    _selectedAddresses.length < 3) {
                                  _selectedAddresses.add(address);
                                } else if (isChecked == false) {
                                  _selectedAddresses.remove(address);
                                } else {
                                  _showAlert('You can select up to 3 addresses.');
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEF923E), // Orange button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover Your Ideal School',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Address Selection
                  Text(
                    'Select Addresses:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _showAddressSelectionDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF923E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Choose Addresses', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 5,
                    children: _selectedAddresses
                        .map((address) => Chip(
                      label: Text(address, overflow: TextOverflow.ellipsis),
                      onDeleted: () => setState(() => _selectedAddresses.remove(address)),
                      backgroundColor: Color(0xFFEF923E),
                      labelStyle: TextStyle(color: Colors.white),
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  // Board Selection
                  Text(
                    'Select Boards (max 2):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _boards.map((board) {
                      return CheckboxListTile(
                        value: _selectedBoards.contains(board),
                        title: Text(board),
                        onChanged: (isChecked) {
                          if (isChecked == true && _selectedBoards.length < 2) {
                            setState(() => _selectedBoards.add(board));
                          } else if (isChecked == false) {
                            setState(() => _selectedBoards.remove(board));
                          } else {
                            _showAlert('You can select up to 2 boards.');
                          }
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),

                  // Fee Range
                  Text(
                    'Select Fee Range:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                    child: DropdownButtonFormField<String>(
                      items: _fees.map((fee) {
                        return DropdownMenuItem(value: fee, child: Text(fee));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedFee = value);
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF923E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('Get Recommendations', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final List schools;

  ResultsScreen({required this.schools});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Recommendations',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: ListView.builder(
        itemCount: schools.length,
        itemBuilder: (context, index) {
          final school = schools[index];
          final matchPercentage = ((100 / 3) * (school['matched'] ?? 0)).round();
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    school['name'] ?? 'School Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text('Matched Attributes: ${school['matchedAttributes'] ?? 'N/A'}'),
                  Text('Address: ${school['address'] ?? 'N/A'}'),
                  Text('Board: ${school['board'] ?? 'N/A'}'),
                  Text('Fee Range: ${school['fees'] ?? 'N/A'}'),
                  Text('Website: ${school['website'] ?? 'Not Available'}'),
                  Text('Contact: ${school['contact'] ?? 'Not Available'}'),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: matchPercentage / 100,
                    backgroundColor: Colors.grey[300],
                    color: Color(0xFFEF923E),
                  ),
                  SizedBox(height: 5),
                  Text('$matchPercentage% Match'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
