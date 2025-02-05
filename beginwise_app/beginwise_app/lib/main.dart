import 'package:beginwise/my_routes.dart';
import 'package:beginwise/screens/about_screeen.dart';
import 'package:beginwise/screens/add_child_form.dart';
import 'package:beginwise/screens/children_screen.dart';
import 'package:beginwise/screens/grade1_screen.dart';
import 'package:beginwise/screens/home_screen.dart';
import 'package:beginwise/screens/interview_questions-screen.dart';
import 'package:beginwise/screens/kgCapital&SmallLetterScreen.dart';
import 'package:beginwise/screens/listening_skills_screen.dart';
import 'package:beginwise/screens/play_group_screen.dart';
import 'package:beginwise/screens/prep_hub_screen.dart';
import 'package:beginwise/screens/profile_screen.dart';
import 'package:beginwise/screens/recognition_page.dart';
import 'package:beginwise/screens/select_test_screen.dart';
import 'package:beginwise/screens/speaking_skills_screen.dart';
import 'package:beginwise/screens/learning_skills_screen.dart';
import 'package:beginwise/screens/motor_skills_screen.dart';
import 'package:beginwise/screens/quiz_skills_screen.dart';
import 'package:beginwise/screens/kindergarten_screen.dart';
import 'package:beginwise/screens/grade1_screen.dart';
import 'package:beginwise/screens/kgGeneral_knowledge_screen.dart';
import 'package:beginwise/screens/kgEnglishScreen.dart';
import 'package:beginwise/screens/kgUrduScreen.dart';
import 'package:beginwise/screens/kgReligiousStudiesScreen.dart';
import 'package:beginwise/screens/kgMathsScreen.dart';
import 'package:beginwise/screens/kgQuizScreen.dart';

import 'package:beginwise/screens/gradeScienceScreen.dart';
import 'package:beginwise/screens/gradeEnglishScreen.dart';
import 'package:beginwise/screens/gradeUrduScreen.dart';
import 'package:beginwise/screens/gradeMathsScreen.dart';
import 'package:beginwise/screens/gradeQuizScreen.dart';
import 'package:beginwise/screens/gradeBodyScreen.dart';
import 'package:beginwise/screens/aadhiShakalScreen.dart';
import 'package:beginwise/screens/alfaazMutazaadScreen.dart';
import 'package:beginwise/screens/waahidJamaScreen.dart';
import 'package:beginwise/screens/muzakkarMonasScreen.dart';
import 'package:beginwise/screens/gradeNounsPronounsScreen.dart';
import 'package:beginwise/screens/gradeTheseThoseScreen.dart';
import 'package:beginwise/screens/gradeWhChShScreen.dart';
import 'package:beginwise/screens/gradeWordOppositesScreen.dart';
import 'package:beginwise/screens/gradeMakeSentencesScreen.dart';
import 'package:beginwise/screens/gradeEssayWritingScreen.dart';
import 'package:beginwise/screens/kgCapital&SmallLetterScreen.dart';
import 'package:beginwise/screens/kgSkyGrassRootLettersScreen.dart';
import 'package:beginwise/screens/kgVowels&ConsonentsScreen.dart';
import 'package:beginwise/screens/kgThis&ThatScreen.dart';
import 'package:beginwise/screens/kgSingularPluralScreen.dart';
import 'package:beginwise/screens/kgRecognitionScreen.dart';
import 'package:beginwise/screens/kgMissingWordsScreen.dart';
import 'package:beginwise/screens/kgMasculineFeminineScreen.dart';
import 'package:beginwise/screens/playgroupShapeRecognition.dart';
import 'package:beginwise/screens/playgroupNumberRecognition.dart';
import 'package:beginwise/screens/schoolFinderScreen.dart';
import 'package:beginwise/screens/showProgressScreen.dart';
import 'package:beginwise/screens/splashScreen.dart';
import 'package:beginwise/screens/animalScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splashScreen,
      routes: {
        MyRoutes.home: (context) => const HomeScreen(),
        MyRoutes.about: (context) => const AboutScreen(),
        MyRoutes.profile: (context) => const ProfileScreen(),
        MyRoutes.childrens: (context) => const ChildrenScreen(),
        MyRoutes.addUser: (context) => const AddChildForm(),
        MyRoutes.prepHub: (context) => PrepHubScreen(),
        MyRoutes.interviewQuestions: (context) => InterviewQuestionsScreen(),
        MyRoutes.selectTest: (context) => SelectTestScreen(childId: '46'),
        MyRoutes.playGroup: (context) => PlayGroupScreen(childId: '46'),
        MyRoutes.speakingSkillsScreen: (context) => SpeakingSkillsScreen(childId: '46'),
        MyRoutes.listeningSkillsScreen: (context) => ListeningSkillsScreen(childId: '46'),
        MyRoutes.learningSkillsScreen: (context) => LearningSkillsScreen(),
        MyRoutes.recognition: (context) => RecognitionPage(),
        MyRoutes.motorSkillsScreen: (context) => MotorSkillsScreen(childId: '46',),
        MyRoutes.quizSkillsScreen: (context) => QuizSkillsScreen(),
        MyRoutes.kindergarten: (context) => Kindergarten(),
        MyRoutes.grade1Screen: (context) => Grade1Screen(),
        MyRoutes.kgGeneralKnowledgeScreen: (context) => KgGeneralKnowledgeScreen(),
        MyRoutes.kgEnglishScreen: (context) => KgEnglishScreen(),
        MyRoutes.kgUrduScreen: (context) => KgUrduScreen(),
        MyRoutes.kgReligiousStudiesScreen: (context) => KgReligiousStudiesScreen(),
        MyRoutes.kgMathsScreen: (context) => KgMathsScreen(),
        MyRoutes.kgQuizScreen: (context) => KgQuizscreen(),

        MyRoutes.gradeScienceScreen: (context) => GradeScienceScreen(),
        MyRoutes.gradeEnglishScreen: (context) => GradeEnglishScreen(),
        MyRoutes.gradeUrduScreen: (context) => GradeUrduScreen(),
        MyRoutes.gradeMathsScreen: (context) => GradeMathsScreen(),
        MyRoutes.gradeQuizScreen: (context) => Gradequizscreen(),
        MyRoutes.gradeBodyScreen: (context) => GradeBodyScreen(),
        MyRoutes.aadhiShakalScreen: (context) => AadhiShakalScreen(),
        MyRoutes.alfaazMutazaadScreen: (context) => AlfaazMutazaadScreen(),
        MyRoutes.waahidJamaScreen: (context) => WaahidJamaScreen(),
        MyRoutes.muzakkarMonasScreen: (context) => MuzakkarMonasScreen(),

        MyRoutes.gradeNounsPronounsScreen: (context) => GradeNounsPronounsScreen(),
        MyRoutes.gradeTheseThoseScreen: (context) => GradeTheseThoseScreen(),
        MyRoutes.gradeWhChShScreen: (context) => GradeWhChShScreen(),
        MyRoutes.gradeWordOppositesScreen: (context) => GradeWordOppositesScreen(),
        MyRoutes.gradeMakeSentencesScreen: (context) => GradeMakeSentencesScreen(),
        MyRoutes.gradeEssayWritingScreen: (context) => GradeEssayWritingScreen(),

        MyRoutes.kgCapitalSmallLetterScreen: (context) => KgCapitalSmallLetterScreen(),
        MyRoutes.kgSkyGrassRootLetters: (context) => KgSkyGrassRootLetters(),
        MyRoutes.kgVowelsConsonents: (context) => KgVowelsConsonents(),
        MyRoutes.kgThisThat: (context) => KgThisThat(),
        MyRoutes.kgSingularPlural: (context) => KgSingularPlural(),
        MyRoutes.kgRecognition: (context) => KgRecognition(),
        MyRoutes.kgMissingWords: (context) => KgMissingWords(),
        MyRoutes.kgMasculineFeminine: (context) => KgMasculineFeminine(),

        MyRoutes.playgroupShapeRecognition: (context) => PlaygroupShapeRecognition(),
        MyRoutes.playgroupNumberRecognition: (context) => PlaygroupNumberRecognition(),
        MyRoutes.schoolFinderScreen: (context) => SchoolFinderScreen(),
        MyRoutes.showProgress: (context) => ShowProgressScreen(),
        MyRoutes.splashScreen: (context) => SplashScreen(),
        MyRoutes.animalScreen: (context) => AnimalScreen(),



      },
    );

  }
}
