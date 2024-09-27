// ignore_for_file: unused_import, unnecessary_null_comparison

import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                    'Log In',
                    style: GoogleFonts.merriweather(
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
                GestureDetector(
                  onTap: () async {
                    brownSnak(context, 'Working on it 😊');
                    // Sends a password recovery email if the provided email is valid and exists in the database,
                    //with error handling for invalid input or missing records.
                    if (logInEmailController.text.isEmpty ||
                        !logInEmailController.text.contains('@') ||
                        !logInEmailController.text.endsWith('.com')) {
                      brownSnak(context, 'Invalid Email ☹');
                    } else {
                      await FirebaseFirestore.instance
                          .collection('UserAccounts')
                          .where('UserEmail',
                              isEqualTo: logInEmailController.text)
                          .get()
                          .then((whereResult) async {
                        if (whereResult == null && whereResult.docs.isEmpty) {
                          redSnak(
                              context, 'There is no record for this email ❌');
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: logInEmailController.text)
                                .then((metaData) {
                              orangeSnak(
                                  context, 'Reset password email sent ✅');
                              logInPassWordController.clear();
                            });
                          } catch (e) {
                            blackSnak(context, 'Error ❌ ');
                          }
                        }
                      });
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
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
void userLogInInputValidation(
  BuildContext context,
  TextEditingController logInEmailController,
  TextEditingController logInPassWordController,
) {
  // Email validation
  if (logInEmailController.text.isEmpty ||
      !logInEmailController.text.contains('@') ||
      !logInEmailController.text.endsWith('.com')) {
    brownSnak(context, 'Invalid Email ☹');
  }
  // Password validation
  else if (logInPassWordController.text.isEmpty ||
      logInPassWordController.text.length < 6) {
    brownSnak(context, 'Password Too Short ☹');
  }
  // Successful validation
  else {
    print('Validation Completed');
    greenSnak(context, 'Validation Completed😍');

    // Delayed execution for login
    Future.delayed(Duration(seconds: 2), () {
      loginUser(logInEmailController, logInPassWordController, context);
    });
  }
}

// This function logs in the user using Firebase Authentication with the provided email and password
// and prints the user ID if login is successful.
Future loginUser(
  dynamic logInEmailController,
  dynamic logInPassWordController,
  BuildContext context,
) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: logInEmailController.text,
      password: logInPassWordController.text,
    )
        .then((userCredential) async {
      var user = userCredential.user;
      if (user != null) {
        print('UserId =  ${user.uid}');
        if (user.emailVerified == false) {
          logInEmailController.clear();
          logInPassWordController.clear();
          userCredential.user?.sendEmailVerification();
          // Handle unverified email case
          print('Email is not verified');
          await FirebaseAuth.instance.signOut().then((_) {
            redSnak(context, 'Email is not verified ✖');
          });
        } else {
          // Fetch user data from Firestore before navigating
          DocumentSnapshot<Map<String, dynamic>> userData =
              await FirebaseFirestore.instance
                  .collection('UserAccounts')
                  .doc(user.uid)
                  .get();
          greenSnak(context, 'Validation Done ✔');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(userData: userData),
            ),
          );
        }
      }
    });
  } on FirebaseAuthException catch (e) {
    print(e.message);
    redSnak(context, 'Error occurred');
  }
}
