import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beginwise/my_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animationOpacity;
  late Animation<double> _animationScale;

  @override
  void initState() {
    super.initState();

    // Create the AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Define the animations
    _animationOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeIn),
    );

    _animationScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
    );

    // Start the animation
    _controller!.forward();

    // Navigate to the next screen after the animation ends
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, MyRoutes.home);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animationOpacity,
          child: ScaleTransition(
            scale: _animationScale,
            child: SvgPicture.asset('assets/img/logo.svg'),
          ),
        ),
      ),
    );
  }
}
