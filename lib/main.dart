import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyB7KOKKDIC5rUBvThNZ0K-HOEkKspbnqDY',
      appId: 'plantio-app-4b746',
      messagingSenderId: '129805791304',
      projectId: 'plantio-app-4b746',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Screen',
      home: SplashScreen(),
    );
  }
}
