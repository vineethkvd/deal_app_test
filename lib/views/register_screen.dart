import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/authFunctionGoogle.dart';
import '../services/authFunctionsEmailPassword.dart';
import '../services/trainercodeemail/utils/fire_auth.dart';
import 'emailvalidationpage.dart';
import 'home_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool passwordVisible = true;

  bool _isProcessing = false;
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
            key: _registerFormKey,
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
                      width: 357,
                      height: 520,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nameTextController,
                            focusNode: _focusName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a name';
                              } else if (value.contains(RegExp(r'[0-9]'))) {
                                return 'Name cannot contain numbers';
                              } else if (value.contains(RegExp(r'\s{2,}'))) {
                                return 'Name cannot have consecutive white spaces';
                              } else if (value
                                  .contains(RegExp(r'[^a-zA-Z\s]'))) {
                                return 'Name cannot contain special characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
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
                            height: 26,
                          ),
                          TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              } else if (!value.contains("@")) {
                                return "please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
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
                            height: 26,
                          ),
                          TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'Please enter a password';
                              }
                              else if(!value.contains(RegExp(r'[0-9]'))){
                                return 'Password must contain at least one number';
                              }
                              else if(!value.contains(RegExp(r'[a-z]'))){
                                return 'Please enter small letters';
                              }
                              else if(!value.contains(RegExp(r'[A-Z]'))){
                                return "Please enter  capital letters";
                              }
                              else if(!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))){
                                return 'Password contain at least one special charcter ';
                              }
                              else if (value.length != 8) {
                                return 'Password must be 8 characters long';
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
                            height: 53,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isProcessing = true;
                                });
                                if (_registerFormKey.currentState!.validate()) {
                                  User? user =
                                      await FireAuth.registerUsingEmailPassword(
                                    name: _nameTextController.text,
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );
                                  setState(() {
                                    _isProcessing = false;
                                  });
                                  if (user != null) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/EmailValidationPage',
                                            (route) => false);
                                  }
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
                            height: 30,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/LoginScreen', (route) => false);
                              },
                              child: Center(
                                child: Text(
                                  "Already have an account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 14),
                                ),
                              )),
                          SizedBox(height: 10)
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
                                        Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
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
