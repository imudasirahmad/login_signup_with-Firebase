import 'package:firebase2/ui/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreen(),
    );
  }
}

