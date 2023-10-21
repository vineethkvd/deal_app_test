import 'package:flutter/material.dart';

import '../services/authFunctionGoogle.dart';
import '../services/authFunctionsEmailPassword.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fullname = '';
  bool passwordVisible = true;
  // bool login = false;
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
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                      width: 357,
                      height: 480,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              } else if (!value.contains("@gmail")) {
                                return "please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            key: ValueKey('email'),
                            onSaved: (newValue) {
                              setState(() {
                                email = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon:Icon(Icons.email),
                                border: OutlineInputBorder(),
                                label: Text(
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          TextFormField(
                            obscureText: passwordVisible,
                            key: ValueKey('password'),
                            onSaved: (newValue) {
                              setState(() {
                                password = newValue!;
                              });
                            },
                            validator: (value) {
                              RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                              );
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              } else if (!regex.hasMatch(value)) {
                                return 'Enter a valid password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Enter the password",
                              labelText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  AuthServices.signinUser(email, password, context);
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
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )),
                          SizedBox(
                            height: 30,
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
                                      'asset/images/google.png'))
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
