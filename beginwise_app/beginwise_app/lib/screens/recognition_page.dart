import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class RecognitionPage extends StatelessWidget {
  const RecognitionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a Game',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),
        ),
        backgroundColor: Color(0xFFEF923E),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a fun game to play!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final gameInfo = [
                    {
                      'title': 'Number Recognition',
                      'icon': Icons.numbers,
                      'color': const Color(0xFF4CAF50),
                      'page': NumberRecognitionGame()
                    },
                    {
                      'title': 'Shape Recognition',
                      'icon': Icons.category,
                      'color': const Color(0xFF2196F3),
                      'page': ShapeRecognitionGame()
                    }
                  ][index];

                  return GameCard(
                    title: gameInfo['title'] as String,
                    icon: gameInfo['icon'] as IconData,
                    color: gameInfo['color'] as Color,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => gameInfo['page'] as Widget),
                      );
                    },
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

class GameCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const GameCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              offset: const Offset(0, 8),
              blurRadius: 12,
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class NumberRecognitionGame extends StatefulWidget {
  @override
  _NumberRecognitionGameState createState() => _NumberRecognitionGameState();
}

class _NumberRecognitionGameState extends State<NumberRecognitionGame> {
  final FlutterTts _flutterTts = FlutterTts();
  final Random _random = Random();
  List<int> _numbers = [];
  int _targetNumber = 0;
  String _feedback = '';
  bool _gameOver = false;
  bool _started = false;

  @override
  void initState() {
    super.initState();
  }

  void _generateNumbers() {
    _numbers = List.generate(6, (_) => _random.nextInt(11));
    _targetNumber = _numbers[_random.nextInt(6)];
  }

  void _speakNumber() async {
    if (!_started) return;
    await _flutterTts.speak('Find the number $_targetNumber');
  }

  void _speakFeedback(String feedback) async {
    await _flutterTts.speak(feedback);
  }

  void _startGame() {
    setState(() {
      _started = true;
      _generateNumbers();
      _feedback = '';
      _gameOver = false;
      _speakNumber();
    });
  }

  void _checkAnswer(int selectedNumber) {
    setState(() {
      if (selectedNumber == _targetNumber) {
        _feedback = 'Correct! Well done!';
        _speakFeedback(_feedback); // Speak feedback
        _generateNumbers(); // Generate new numbers and target for the next round
        _speakNumber();
      } else {
        _feedback = 'Wrong! Try again.';
        _speakFeedback(_feedback); // Speak feedback
      }
    });
  }

  void _resetGame() {
    setState(() {
      _gameOver = false;
      _feedback = '';
      _generateNumbers();
      _speakNumber();
    });
  }

  Color _getRandomColor() {
    return Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Recognition Game',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_started) ...[
              Center(
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF923E)),
                  child: Text('Start Game'),
                ),
              ),
            ] else ...[
              Text(
                'Find the number spoken:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: _numbers.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      _checkAnswer(_numbers[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getRandomColor(), // Random background color
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      _numbers[index].toString(),
                      style: TextStyle(fontSize: 18, color: Colors.white), // White text color
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                _feedback,
                style: TextStyle(fontSize: 18, color: _feedback == 'Correct! Well done!' ? Colors.green : Colors.red),
              ),
              SizedBox(height: 20),
              if (_feedback == 'Wrong! Try again.')
                ElevatedButton(
                  onPressed: _resetGame,
                  child: Text('Play Again'),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF923E)),
                ),
            ]
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class ShapeRecognitionGame extends StatefulWidget {
  @override
  _ShapeRecognitionGameState createState() => _ShapeRecognitionGameState();
}


class _ShapeRecognitionGameState extends State<ShapeRecognitionGame> {
  final FlutterTts _flutterTts = FlutterTts();
  int _currentShapeIndex = 0;
  final List<Map<String, dynamic>> _shapes = [
    {'name': 'Circle', 'icon': Icons.circle},
    {'name': 'Square', 'icon': Icons.crop_square},
    {'name': 'Triangle', 'icon': Icons.change_history},
    {'name': 'Rectangle', 'icon': Icons.crop_16_9},
    {'name': 'Oval', 'icon': Icons.panorama_fish_eye},
    {'name': 'Star', 'icon': Icons.star},
    {'name': 'Heart', 'icon': Icons.favorite},
  ];

  String _feedback = '';
  bool _gameOver = false;
  bool _started = false;

  void _speakShape() async {
    if (_started && _currentShapeIndex < _shapes.length) {
      await _flutterTts.speak('Can you find the shape ${_shapes[_currentShapeIndex]['name']}?');
    }
  }

  void _speakFeedback(String feedback) async {
    await _flutterTts.speak(feedback);
  }

  void _checkAnswer(String shape) {
    setState(() {
      if (_currentShapeIndex < _shapes.length) {
        if (shape == _shapes[_currentShapeIndex]['name']) {
          _feedback = 'Correct! Well done!';
          _speakFeedback(_feedback); // Speak feedback
          _currentShapeIndex++;
          if (_currentShapeIndex >= _shapes.length) {
            _gameOver = true;
            _feedback = 'Congratulations! You recognized all shapes!';
            _speakFeedback(_feedback); // Speak feedback
            _showCongratulationDialog();
          } else {
            _speakShape();
          }
        } else {
          _feedback = 'Wrong! Try again.';
          _speakFeedback(_feedback); // Speak feedback
        }
      }
    });
  }

  void _startGame() {
    setState(() {
      _started = true;
      _currentShapeIndex = 0;
      _feedback = '';
      _gameOver = false;
      _speakShape();
    });
  }

  void _resetGame() {
    setState(() {
      _gameOver = false;
      _started = false;
      _currentShapeIndex = 0;
      _feedback = '';
      _startGame();
    });
  }

  void _showCongratulationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have successfully recognized all the shapes!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shape Recognition Game',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Use the accent color for the app bar title
          ),),
        backgroundColor: Color(0xFFEF923E),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_started) ...[
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF923E)),
                  child: Text('Start Game', style: TextStyle(fontSize: 18)),
                ),
              ] else ...[
                Text(
                  'Find the shape spoken:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: _shapes.map((shape) {
                    return ElevatedButton(
                      onPressed: () => _checkAnswer(shape['name']),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(shape['icon'], size: 50, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            shape['name'],
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEF923E),
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  _feedback,
                  style: TextStyle(
                    fontSize: 18,
                    color: _feedback.contains('Correct') ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                if (_feedback == 'Wrong! Try again.') ...[
                  ElevatedButton(
                    onPressed: _resetGame,
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF923E)),
                    child: Text('Play Again'),
                  ),
                ],
                if (_gameOver) ...[
                  ElevatedButton(
                    onPressed: _resetGame,
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF923E)),
                    child: Text('Play Again'),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}



