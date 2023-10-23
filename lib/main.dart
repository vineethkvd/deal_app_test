import 'package:deal_app_test/services/trainercodeemail/screens/login_page.dart';
import 'package:deal_app_test/views/emailvalidationpage.dart';
import 'package:deal_app_test/views/home_page.dart';
import 'package:deal_app_test/views/login_screen.dart';
import 'package:deal_app_test/views/register_screen.dart';
import 'package:deal_app_test/views/splash_screen.dart';
import 'package:deal_app_test/views/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          '/SplashScreen':(context) => SplashScreen(),
          '/LoginScreen':(context) => LoginScreen(),
          '/WelcomeScreen':(context) => WelcomeScreen(),
          '/RegisterScreen':(context) => RegisterScreen(),
          '/EmailValidationPage': (context) {
            User? user = FirebaseAuth.instance.currentUser;
            return EmailValidationPage(user: user!);
          },
          '/HomePage':(context) =>HomePage(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SplashScreen();
            }
          },
        ));
  }
}