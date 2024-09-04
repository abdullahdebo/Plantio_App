// ignore_for_file: unused_import

import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/snackBar.dart';
import 'package:plantio_app/ui/home_page.dart';
import 'package:plantio_app/ui/signup_screen.dart';
import 'package:plantio_app/ui/splash_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // To Control User Inputs
  TextEditingController logInEmailController = TextEditingController();
  TextEditingController logInPassWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blanketColor,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'LogIn',
                    style: GoogleFonts.rubik(
                      color: Constants.primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/4.png',
                  height: 300,
                  width: 300,
                ),
                SizedBox(height: 2),
                TextField(
                  controller: logInEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.email, color: Constants.primaryColor),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.rubik(
                      color: Constants.primaryColor,
                    ),
                    filled: true,
                    fillColor: Constants.mushroomColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: logInPassWordController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Constants.primaryColor),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.rubik(
                      color: Constants.primaryColor,
                    ),
                    filled: true,
                    fillColor: Constants.mushroomColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    userLogInInputValidation(
                        context, logInEmailController, logInPassWordController);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Constants.blanketColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.rubik(
                        color: Constants.khakiMossColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignupScreen()));
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.rubik(
                          color: Constants.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Validates user login input fields and displays appropriate snack messages based on the validation results.
void userLogInInputValidation(BuildContext context,
    dynamic logInEmailController, dynamic logInPassWordController) {
  if (logInEmailController.text.isEmpty ||
      logInEmailController.text.contains('@') == false ||
      logInEmailController.text.contains('.com') == false) {
    brownSnak(context, 'invalid email ☹');
  } else if (logInPassWordController.text.isEmpty ||
      logInPassWordController.text.length < 6) {
    brownSnak(context, 'password too short ☹');
  } else {
    greenSnak(context, 'Validation Completed😍');
  }
}
