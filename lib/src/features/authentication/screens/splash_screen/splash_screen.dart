import 'package:flutter/material.dart';
import 'package:login/src/constants/image_strings.dart';
import 'package:login/src/features/authentication/screens/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation(); // Start the animation when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF1A8BA),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            curve: Curves.easeInOut,
            top: animate
                ? screenHeight
                : screenHeight / 2 - 100, // Start at mid and move off-screen
            left: 0,
            right: 0,
            child: const Image(
              image: AssetImage(tSplashLogo),
              width: 350,
              height: 350,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000)); // Initial delay
    setState(() => animate = true); // Trigger the animation to move down

    // Wait for the animation to complete
    await Future.delayed(const Duration(milliseconds: 1600));

    // Ensure the widget is still mounted before navigating to the next screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppHome()),
      );
    }
  }
}
