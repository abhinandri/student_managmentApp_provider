
import 'package:flutter/material.dart';

import 'package:provider_student_app/view/homepage.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Future.delayed for navigation
    Future.delayed(const Duration(seconds: 3), () {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.purple,
      body: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1500),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: value,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your app logo here
                    Icon(
                      Icons.school, // Replace with your app icon
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'EduTrack', // Replace with your app name
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
