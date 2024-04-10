import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/firebase_options.dart';
import 'package:spnr30app/X_no_need_actually/X_choose_screen_page.dart';
import 'package:spnr30app/pages/home_page.dart';
import 'package:spnr30app/pages/profile_page.dart';
import 'package:spnr30app/pages/users_page.dart';
import 'pages/auth_page.dart';

void main() async {
//FIREBASE FIRESTORE
//init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//init app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthPage(),
      routes: {
        '/choose_screen_page': (context) => const ChooseScreenPage(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => const ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}
