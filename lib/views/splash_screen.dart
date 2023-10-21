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
                image: AssetImage('asset/images/On boarding.png'))),
        child: Stack(children: [
          Align(
            alignment: Alignment(0, 0.15),
            child: Container(
              child: Text(
                "Deal Ninja",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontFamily: 'Outfit-SemiBold',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.35),
            child: Container(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Unlock Your Savings Superpowers",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Outfit-SemiBold',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "with Deal Ninja App!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Outfit-SemiBold',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: Container(
              child: CircularProgressIndicator(color: Color(0xFFCFFF0F),),
            ),
          )
        ]),
      ),
    );
  }
}
