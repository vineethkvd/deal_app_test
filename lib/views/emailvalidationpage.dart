import 'package:flutter/material.dart';

class EmailValidationPage extends StatefulWidget {
  const EmailValidationPage({super.key});

  @override
  State<EmailValidationPage> createState() => _EmailValidationPageState();
}

class _EmailValidationPageState extends State<EmailValidationPage> {
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
      ),
    );
  }
}
