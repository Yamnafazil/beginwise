import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class KgSingularPlural extends StatefulWidget {
  @override
  _KgSingularPluralState createState() => _KgSingularPluralState();
}

class _KgSingularPluralState extends State<KgSingularPlural> {
  FlutterTts flutterTts = FlutterTts();
  String feedback = '';
  String correctAnswer = '';
  bool isDialogVisible = false;

  Map<String, bool> droppedItems = {
    'singularCat': false,
    'pluralCat': false,
    'singularDog': false,
    'pluralDog': false,
    'singularBox': false,
    'pluralBox': false,
    'singularChair': false,
    'pluralChair': false,
  };

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.5);
  }

  void _speakFeedback(String message) {
    flutterTts.speak(message);
  }

  void handleDrop(String type, String id) {
    setState(() {
      if ((type == 'singularCat' && id == 'cat') ||
          (type == 'pluralCat' && id == 'cats') ||
          (type == 'singularDog' && id == 'dog') ||
          (type == 'pluralDog' && id == 'dogs') ||
          (type == 'singularBox' && id == 'box') ||
          (type == 'pluralBox' && id == 'boxes') ||
          (type == 'singularChair' && id == 'chair') ||
          (type == 'pluralChair' && id == 'chairs')) {
        feedback = "Great! You got it right.";
        correctAnswer = id;
        droppedItems[type] = true;
      } else {
        feedback = "Oops! Try again.";
        correctAnswer = '';
      }

      if (!isDialogVisible) {
        isDialogVisible = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showFeedbackDialog(context, feedback);
        });
      }

      if (_checkCompletion()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showCompletionDialog(context);
        });
      }
    });
  }

  bool _checkCompletion() {
    return droppedItems.values.every((value) => value);
  }

  void _showFeedbackDialog(BuildContext context, String message) {
    _speakFeedback(message);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isDialogVisible = false;
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCompletionDialog(BuildContext context) {
    _speakFeedback('Congratulations! You have successfully completed the activity!');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have successfully completed the activity!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetActivity();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetActivity() {
    setState(() {
      feedback = '';
      correctAnswer = '';
      isDialogVisible = false;
      droppedItems = {
        'singularCat': false,
        'pluralCat': false,
        'singularDog': false,
        'pluralDog': false,
        'singularBox': false,
        'pluralBox': false,
        'singularChair': false,
        'pluralChair': false,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Singular and Plural',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Let\'s Learn Singular and Plural',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Singular means one object, and plural means more than one.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Text(
                'Examples',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ExampleWidget(image: 'assets/img/kg_english/apple.png', label: '1 Apple (Singular)'),
                  ),
                  Flexible(
                    child: ExampleWidget(image: 'assets/img/kg_english/apples.png', label: '5 Apples (Plural)'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ExampleWidget(image: 'assets/img/kg_english/ball.png', label: '1 Ball (Singular)'),
                  ),
                  Flexible(
                    child: ExampleWidget(image: 'assets/img/kg_english/balls.png', label: '8 Balls (Plural)'),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Drag and drop correct Singular and Plural',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              _buildDragDropRow('Singular:', 'singularCat', 'Plural:', 'pluralCat', 'Cats', 'cat'),
              SizedBox(height: 40),
              _buildDragDropRow('Singular:', 'singularDog', 'Plural:', 'pluralDog', 'Dogs', 'dog'),
              SizedBox(height: 40),
              _buildDragDropRow('Singular:', 'singularBox', 'Plural:', 'pluralBox', 'Boxes', 'box'),
              SizedBox(height: 40),
              _buildDragDropRow('Singular:', 'singularChair', 'Plural:', 'pluralChair', 'Chairs', 'chair'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget _buildDragDropRow(String singularLabel, String singularId, String pluralLabel, String pluralId, String pluralText, String singularText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(singularLabel),
            DragTarget<String>(
              onWillAccept: (id) => !droppedItems[singularId]!,
              onAccept: (id) => handleDrop(singularId, id),
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 150,
                  height: 50,
                  color: droppedItems[singularId]! ? Colors.green : Colors.orangeAccent,
                  alignment: Alignment.center,
                  child: Text('Singular'),
                );
              },
            ),
            const SizedBox(height: 10),
            if (!droppedItems[singularId]!)
              Draggable<String>(
                data: singularText.toLowerCase(),
                child: _dragItemContainer(singularText),
                feedback: _dragItemFeedback(singularText),
                childWhenDragging: Container(),
              ),
          ],
        ),
        Column(
          children: [
            Text(pluralLabel),
            DragTarget<String>(
              onWillAccept: (id) => !droppedItems[pluralId]!,
              onAccept: (id) => handleDrop(pluralId, id),
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 150,
                  height: 50,
                  color: droppedItems[pluralId]! ? Colors.green : Colors.orangeAccent,
                  alignment: Alignment.center,
                  child: Text('Plural'),
                );
              },
            ),
            const SizedBox(height: 10),
            if (!droppedItems[pluralId]!)
              Draggable<String>(
                data: pluralText.toLowerCase(),
                child: _dragItemContainer(pluralText),
                feedback: _dragItemFeedback(pluralText),
                childWhenDragging: Container(),
              ),
          ],
        ),
      ],
    );
  }

  Widget _dragItemContainer(String text) {
    return Container(
      width: 100,
      height: 50,
      color: Colors.orange,
      alignment: Alignment.center,
      child: Text(text),
    );
  }

  Widget _dragItemFeedback(String text) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 100,
        height: 50,
        color: Colors.orange,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  final String image;
  final String label;

  ExampleWidget({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, width: 150, height: 150),
        Text(label),
      ],
    );
  }
}
