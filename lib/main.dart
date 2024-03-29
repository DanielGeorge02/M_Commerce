import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:m_commerce/pages/login/userType.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(ProviderScope(
      child: MyApp(
    isLoggedIn: isLoggedIn,
  )));
}

class MyApp extends ConsumerStatefulWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Future<void> getSharedPreferenceValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ref.read(emailProvider.notifier).state = prefs.getString('email') ?? '';
    ref.read(userTypeProvider.notifier).state =
        prefs.getString('userType') ?? '';
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferenceValue();
  }

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
            nextScreen: widget.isLoggedIn ? const Home() : const LoginPage()),
      ),
    );
  }
}
