import 'package:flutter/material.dart';

class PlaygroupShapeRecognition extends StatefulWidget {
  @override
  _PlaygroupShapeRecognitionState createState() =>
      _PlaygroupShapeRecognitionState();
}

class _PlaygroupShapeRecognitionState extends State<PlaygroupShapeRecognition> {
  bool gameStarted = false;
  String shapeToDisplay = "🔵"; // Default shape
  String congratulationsMessage = "";

  void startGame() {
    setState(() {
      gameStarted = true;
    });
  }

  void checkShape(String shape) {
    setState(() {
      if (shape == shapeToDisplay) {
        congratulationsMessage = "Correct!";
      } else {
        congratulationsMessage = "Try Again!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/gamebg.png'), // Example background
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: gameStarted
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Identify the Shape",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 3,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          colors: [Colors.teal[100]!, Colors.teal[200]!],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        shapeToDisplay,
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      congratulationsMessage,
                      style: TextStyle(
                        fontSize: 24,
                        color: congratulationsMessage == "Correct!"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        buildShapeButton("🔵", "Circle"),
                        buildShapeButton("⬛", "Square"),
                        buildShapeButton("🔺", "Triangle"),
                        buildShapeButton("⬜", "Rectangle"),
                        buildShapeButton("🛑", "Hexagon"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Playgroup Shape Recognition",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: startGame,
                child: Text("Start Game"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShapeButton(String shape, String shapeName) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(20),
      ),
      onPressed: () => checkShape(shape),
      child: Text(
        shape,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
