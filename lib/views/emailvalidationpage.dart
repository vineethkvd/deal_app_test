import 'package:deal_app_test/views/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/trainercodeemail/utils/fire_auth.dart';
import 'login_screen.dart';

class EmailValidationPage extends StatefulWidget {
  final User user;

  const EmailValidationPage({required this.user});

  @override
  State<EmailValidationPage> createState() => _EmailValidationPageState();
}

class _EmailValidationPageState extends State<EmailValidationPage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;
  @override
  void initState() {
    // TODO: implement initState
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('asset/images/Welcome Screen .png'))),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(0, -0.7),
                  child: Container(
                      child: Image.asset(
                    'asset/images/icons8-email-64.png',
                    height: 250,
                    width: 400,
                  )),
                ),
                Align(
                  alignment: Alignment(0, -0.4),
                  child: Container(
                    child: Text("Verify your email address",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: Color(0xFF1F41BB))),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0x91595959),
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NAME: ${_currentUser.displayName}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'EMAIL: ${_currentUser.email}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 16.0),
                          _currentUser.emailVerified
                              ? Text(
                                  'Email verified',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.green),
                                )
                              : Text(
                                  'Email not verified',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.red),
                                ),
                          SizedBox(height: 16.0),
                          _isSendingVerification
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isSendingVerification = true;
                                        });
                                        await _currentUser
                                            .sendEmailVerification();
                                        setState(() {
                                          _isSendingVerification = false;
                                        });
                                      },
                                      child: Text('Verify email'),
                                    ),
                                    SizedBox(width: 8.0),
                                    IconButton(
                                      icon: Icon(Icons.refresh),
                                      onPressed: () async {
                                        //sending email verification
                                        User? user = await FireAuth.refreshUser(
                                            _currentUser);

                                        if (user != null) {
                                          setState(() {
                                            _currentUser = user;
                                          });
                                        }
                                        if (_currentUser.emailVerified) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/HomePage',
                                                  (route) => false);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                          SizedBox(height: 16.0),
                          _isSigningOut
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isSigningOut = true;
                                    });
                                    await FirebaseAuth.instance.signOut();
                                    setState(() {
                                      _isSigningOut = false;
                                    });
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text('Sign out'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
