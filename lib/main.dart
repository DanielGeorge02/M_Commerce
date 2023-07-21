import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'dart:js_interop';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home': (context) => const Home(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.black)),
      home: Scaffold(
        body: AnimatedSplashScreen(
            splash: Image.asset(
              "images/splash.png",
            ),
            splashIconSize: double.infinity,
            duration: 3000,
            backgroundColor: Colors.white,
            splashTransition: SplashTransition.slideTransition,
            nextScreen: FirebaseAuth.instance.currentUser == null
                ? LoginPage()
                : Home()),
      ),
    );
  }
}
