import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class AnimalScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  AnimalScreen({Key? key}) : super(key: key);

  Future<void> readAnimalName(String animalName) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(animalName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Science - Grade Screen'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bright_squares.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Animal Sound Experience',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEF923E),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Click on an animal to hear its name! Explore different categories like wild, pet, and domestic animals.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ),
              buildSectionTitle('Wild Animals'),
              buildAnimalGrid([
                Animal(name: 'Lion', imageUrl: 'https://cdn.pixabay.com/photo/2023/09/22/06/44/lion-8268242_960_720.jpg'),
                Animal(name: 'Elephant', imageUrl: 'https://cdn.pixabay.com/photo/2017/11/06/15/30/elephant-2923916_640.jpg'),
                Animal(name: 'Tiger', imageUrl: 'https://cdn.pixabay.com/photo/2018/10/01/08/52/tiger-3715664_1280.jpg'),
                Animal(name: 'Giraffe', imageUrl: 'https://cdn.pixabay.com/photo/2020/11/09/10/31/giraffe-5726193_1280.jpg'),
                Animal(name: 'Zebra', imageUrl: 'https://cdn.pixabay.com/photo/2020/03/10/04/48/animal-4917802_1280.jpg'),
              ]),
              buildSectionTitle('Pet Animals'),
              buildAnimalGrid([
                Animal(name: 'Dog', imageUrl: 'https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_1280.jpg'),
                Animal(name: 'Cat', imageUrl: 'https://cdn.pixabay.com/photo/2017/11/09/21/41/cat-2934720_1280.jpg'),
                Animal(name: 'Parrot', imageUrl: 'https://cdn.pixabay.com/photo/2023/02/15/13/19/bird-7791901_640.jpg'),
                Animal(name: 'Rabbit', imageUrl: 'https://cdn.pixabay.com/photo/2022/04/07/02/56/cottontail-rabbit-7116707_640.jpg'),
                Animal(name: 'Hamster', imageUrl: 'https://cdn.pixabay.com/photo/2018/02/18/13/03/cute-3162209_640.jpg'),
              ]),
              buildSectionTitle('Domestic Animals'),
              buildAnimalGrid([
                Animal(name: 'Cow', imageUrl: 'https://cdn.pixabay.com/photo/2021/06/24/07/29/cow-6360406_640.jpg'),
                Animal(name: 'Sheep', imageUrl: 'https://cdn.pixabay.com/photo/2022/11/29/16/51/sheep-7624863_640.jpg'),
                Animal(name: 'Goat', imageUrl: 'https://cdn.pixabay.com/photo/2020/09/01/17/19/goat-5535783_640.jpg'),
                Animal(name: 'Chicken', imageUrl: 'https://cdn.pixabay.com/photo/2018/10/11/23/08/chicken-3741129_640.jpg'),
                Animal(name: 'Horse', imageUrl: 'https://cdn.pixabay.com/photo/2023/07/03/14/36/horse-8104389_640.jpg'),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildAnimalGrid(List<Animal> animals) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: animals
            .map((animal) => GestureDetector(
          onTap: () => readAnimalName(animal.name),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    animal.imageUrl,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    animal.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}

class Animal {
  final String name;
  final String imageUrl;

  Animal({required this.name, required this.imageUrl});
}
