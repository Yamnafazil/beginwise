import 'package:flutter/material.dart';

class PlaygroupNumberRecognition extends StatefulWidget {
  @override
  _NumberRecognitionGameState createState() => _NumberRecognitionGameState();
}

class _NumberRecognitionGameState extends State<PlaygroupNumberRecognition> {
  int currentNumber = 1;
  final int totalNumbers = 32;
  bool gameStarted = false;
  bool showCongrats = false;

  void handleNumberClick(int number) {
    setState(() {
      if (number == currentNumber) {
        if (currentNumber == totalNumbers) {
          showCongrats = true;
        } else {
          currentNumber++;
        }
      }
    });
  }

  void restartGame() {
    setState(() {
      currentNumber = 1;
      gameStarted = false;
      showCongrats = false;
    });
  }

  void startGame() {
    setState(() {
      gameStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/gamebg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: !gameStarted
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Start Game',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Number Recognition',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    '$currentNumber',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(
                    totalNumbers,
                        (index) => ElevatedButton(
                      onPressed: () => handleNumberClick(index + 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.primaries[index % Colors.primaries.length],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(20),
                        elevation: 8,
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showCongrats)
            Center(
              child: AlertDialog(
                title: Text('Congratulations!'),
                content: Text('You have recognized all numbers.'),
                actions: [
                  TextButton(
                    onPressed: restartGame,
                    child: Text('Restart'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add navigation back logic here
                    },
                    child: Text('Go Back'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
