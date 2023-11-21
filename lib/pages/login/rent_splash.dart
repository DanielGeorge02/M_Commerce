import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/pages/home/homepage.dart';

import '../Rent_page/rent_Bottom.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Rent_BottomNav()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.light(primary: Colors.black)),
      home: Scaffold(
        body: AnimatedSplashScreen(
            splash: Image.asset(
              "images/rent_splash.png",
            ),
            splashIconSize: double.infinity,
            duration: 2000,
            backgroundColor: Colors.white,
            splashTransition: SplashTransition.sizeTransition,
            nextScreen: const Homepage()),
      ),
    );
  }
}
