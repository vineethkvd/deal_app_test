import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: size.height,
            width: size.width,
            // padding: EdgeInsets.only(top: 65, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(children: [
              Positioned(
                  top: 0,
                  left: 220,
                  child: Image.asset('asset/images/Ellipse 1.png')),
              Align(
                alignment: Alignment(0, -0.88),
                child: Container(
                  height: 165,
                  width: 350,
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Login here",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontWeight: FontWeight.w800,
                                fontSize: 35,
                                color: Color(0xFF1F41BB))),
                        SizedBox(
                          height: 19,
                        ),
                        Text(
                          "Welcome back you’ve",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: ' Poppins-SemiBold'),
                        ),
                        Text(
                          "been missed!",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: ' Poppins-SemiBold'),
                        )
                      ]),
                ),
              ),
              Positioned(
                top: 302,
                bottom: 180,
                left: 20,
                right: 20,
                child: Container(
                    // color: Colors.red,
                    height: 350,
                    width: 345,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                "Email",
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                "Password",
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(
                                  color: Color(0xFF1F41BB),
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 14),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStatePropertyAll(
                                    Size(size.width, 46)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF1F41BB))),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Create new account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              )),
                        )
                      ],
                    )),
              ),
              Align(
                alignment: Alignment(0, 0.99),
                child: Container(
                    height: 150,
                    child: Column(
                      children: [
                        Text(
                          "Or continue with",
                          style: TextStyle(
                              color: Color(0xFF1F41BB),
                              fontFamily: 'Poppins-Regular',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    width: 60,
                                    height: 30,
                                    'asset/images/google.png')),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    width: 60,
                                    height: 30,
                                    'asset/images/facebook.png'))
                          ],
                        )
                      ],
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
