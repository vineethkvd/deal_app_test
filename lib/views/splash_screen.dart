import 'dart:async';

import 'package:deal_app_test/views/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 65, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('asset/images/Splash Screen.png'))),
        child: Stack(children: [
          Align(
            alignment: Alignment(0, 0.7),
            child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('asset/images/logo.png'),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "OFFER",
                      style: TextStyle(
                          color: Color(0xFFC50000),
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          fontFamily: ' Poppins-SemiBold'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "NINJA",
                      style: TextStyle(
                          color: Color(0xBD5E0000),
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          fontFamily: ' Poppins-SemiBold'),
                    )
                  ],
                )),
          ),
          Align(
            alignment: Alignment(0, 0.93),
            child: Container(child: CircularProgressIndicator(color: Color(0xFFBB6B00),)),
          )
        ]),
      ),
    );
  }
}
