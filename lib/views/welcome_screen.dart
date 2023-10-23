import 'package:deal_app_test/views/login_screen.dart';
import 'package:deal_app_test/views/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('asset/images/Welcome Screen .png'))),
            child: Stack(children: [
              Align(
                alignment: Alignment(0, -1),
                child: Image.asset('asset/images/welcome image.png'),
              ),
              Align(
                alignment: Alignment(0, 0.2),
                child: Container(
                  height: 165,
                  width: 350,
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Discover Your",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontWeight: FontWeight.w800,
                                fontSize: 35,
                                color: Color(0xFF1F41BB))),
                        Text("Dream deals here",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontWeight: FontWeight.w800,
                                fontSize: 35,
                                color: Color(0xFF1F41BB))),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Explore all the existing job roles based on your",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: ' Poppins-Regular'),
                        ),
                        Text(
                          "interest and study major",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: ' Poppins-Regular'),
                        )
                      ]),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Container(
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/LoginScreen', (route) => false);
                            },
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStatePropertyAll(Size(140, 46)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF1F41BB))),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/RegisterScreen', (route) => false);
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Color(0xFF1F41BB)),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(140, 46)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF595959))),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                      ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
