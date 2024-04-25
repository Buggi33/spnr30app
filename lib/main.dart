import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spnr30app/api/FirebaseApi.dart';
import 'package:spnr30app/firebase_options.dart';
import 'package:spnr30app/pages/admin_payments_page.dart';
import 'package:spnr30app/pages/contact_page.dart';
import 'package:spnr30app/pages/home_page.dart';
import 'package:spnr30app/pages/profile_page.dart';
import 'package:spnr30app/pages/payments_page.dart';
import 'package:spnr30app/providers/checkbox_provider.dart';
import 'pages/auth_page.dart';

void main() async {
//FIREBASE FIRESTORE
//init firebase
  WidgetsFlutterBinding.ensureInitialized();
  // MyGoogleSheetApi().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotificationsAndGetToken();
//init app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CheckboxProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
        routes: {
          '/contact_page': (context) => const ContactPage(),
          '/home_page': (context) => const HomePage(),
          '/profile_page': (context) => const ProfilePage(),
          '/users_page': (context) => const PaymentsPage(),
          '/admin_payments_page': (context) => const AdminPaymentsPage(),
        },
      ),
    );
  }
}
