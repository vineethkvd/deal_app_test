import 'package:flutter/material.dart';

import '../services/authFunctionGoogle.dart';
import '../services/authFunctionsEmailPassword.dart';
import 'home_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fullname = '';
  bool login = false;
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
          child: Form(
            key: _formKey,
            child: Container(
              height: size.height,
              width: size.width,
              // padding: EdgeInsets.only(top: 65, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('asset/images/Welcome Screen .png'))),
              child: Stack(children: [
                Align(
                  alignment: Alignment(0, -0.88),
                  child: Container(
                    height: 165,
                    width: 350,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Create Account",
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 35,
                                  color: Color(0xFF1F41BB))),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Create an account so you can explore all the",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: ' Poppins-SemiBold'),
                          ),
                          Text(
                            "existing jobs",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: ' Poppins-SemiBold'),
                          )
                        ]),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                      // color: Colors.red,
                      height: 350,
                      width: 440,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            key: ValueKey('fullname'),
                            onSaved: (newValue) {
                              setState(() {
                                fullname = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name should not be empty";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter the name",
                                label: Text(
                                  "Name",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: ValueKey('email'),
                            onSaved: (newValue) {
                              setState(() {
                                email = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              } else if (!value.contains("@gmail")) {
                                return "please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter the email",
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
                            key: ValueKey('password'),
                            onSaved: (newValue) {
                              setState(() {
                                password = newValue!;
                              });
                            },
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              } else {
                                if (!regex.hasMatch(value)) {
                                  return 'Enter valid password';
                                } else {
                                  return null;
                                }
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter the password",
                                label: Text(
                                  "Password",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  AuthServices.signupUser(
                                      email, password, fullname, context);
                                }
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
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Already have an account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 14),
                              ))
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
                                  onPressed: () {
                                    signInWithGoogle().then((result) {
                                      if (result != null) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ));
                                      }
                                    });
                                    print("clicked");
                                  },
                                  icon: Image.asset(
                                      width: 60,
                                      height: 30,
                                      'asset/images/google.png')),
                            ],
                          )
                        ],
                      )),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
