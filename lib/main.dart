import 'package:fixerhub/signup.dart';
import 'package:fixerhub/wellcome.dart';
import 'package:fixerhub/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'forgotpassword.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixerHub',
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome', // Set the initial route
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/resetpswd': (context) => const ForgotPasswordScreen(),
        '/home' : (context) => const HomeScreen(),
      },
    );
  }
}