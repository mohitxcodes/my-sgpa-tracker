import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/pages/loading-screen/loading.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Connected to Firebase");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.red,
      ),
      home: const LoadingPage(),
    );
  }
}
