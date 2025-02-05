import 'package:beginwise/my_routes.dart';
import 'package:flutter/material.dart';

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home Button
          IconButton(
            icon: const Icon(Icons.home),
            color: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.home); // Navigate to Home
            },
          ),
          // Prep Hub Button
          IconButton(
            icon: const Icon(Icons.school),
            color: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.prepHub); // Navigate to Prep Hub
            },
          ),

          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.schoolFinderScreen); // Navigate to Prep Hub
            },
          ),

          // Children's Button
          IconButton(
            icon: const Icon(Icons.child_care_rounded),
            color: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.childrens); // Navigate to Children's Page
            },
          ),
          // Profile Button
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.profile); // Navigate to Profile
            },
          ),
        ],
      ),
    );
  }
}
