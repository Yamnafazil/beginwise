import 'package:flutter/material.dart';
import 'package:beginwise/widgets/my_bottom_navigation.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('logo.png', width: 100,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "Our Mission" section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Our ',
                        style: TextStyle(
                          color: Colors.orange, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Mission',
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "At BeginWise, our mission is to revolutionize the way parents and students navigate the education landscape. We believe that every child deserves access to quality education tailored to their unique needs and aspirations. With this vision in mind, we have developed a comprehensive platform that empowers parents to make informed decisions about their child's education while providing students with the tools and resources they need to succeed academically.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                
                // "Who We Are?" section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Who ',
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'We Are?',
                        style: TextStyle(
                          color: Colors.orange, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                // Image Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('about1.jpg', width: double.infinity),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "BeginWise is a team of passionate educators, developers, and innovators dedicated to reshaping the future of education. With a deep understanding of the challenges faced by parents and students in today's educational environment, we are committed to leveraging technology and data-driven insights to create impactful solutions that make a difference in the lives of families across the globe.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        
                // Another Image Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('about2.png', width: double.infinity),
                  ),
                ),
                
                // "Our Approach" section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Our ',
                        style: TextStyle(
                          color: Colors.orange, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Approach',
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "At BeginWise, we believe in the power of personalized learning and informed decision-making. Our platform utilizes cutting-edge machine learning algorithms to provide tailored school recommendations based on user preferences and data analysis. Additionally, we offer a range of resources and tools, including exam preparation materials, educational games, and interview guidance, to support students at every stage of their academic journey.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        
                // "Why Choose Us?" section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Why ',
                        style: TextStyle(
                          color: Colors.orange, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Choose Us?',
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "With BeginWise, parents can trust that they are making the best decisions for their child's education. Our platform offers transparency, reliability, and convenience, allowing parents to access comprehensive information about schools and educational resources in one centralized location. Moreover, our commitment to continuous improvement ensures that our platform evolves to meet the changing needs of families and educational institutions alike.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                
                
              ]
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
