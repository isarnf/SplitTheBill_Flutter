import 'package:flutter/material.dart';
import 'package:split_the_bill/firebase_options.dart';
import 'package:split_the_bill/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

Future main () async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
