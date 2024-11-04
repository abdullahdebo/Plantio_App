// ignore_for_file: unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/snackBar.dart';
import 'package:plantio_app/ui/login_screen.dart';

import '../constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // To Control User Inputs
  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPassWordController = TextEditingController();

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
                    'Sign Up',
                    style: GoogleFonts.merriweather(
                      color: Constants.primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/5.png',
                  height: 270,
                  width: 270,
                ),
                SizedBox(height: 2),
                TextField(
                  controller: signUpFirstNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.person, color: Constants.primaryColor),
                    hintText: 'First Name',
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
                  controller: signUpLastNameController,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.person, color: Constants.primaryColor),
                    hintText: 'Last Name',
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
                  controller: signUpEmailController,
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
                  controller: signUpPassWordController,
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
                ElevatedButton(
                  onPressed: () {
                    userSignUpInputValidation(
                      context,
                      signUpFirstNameController,
                      signUpLastNameController,
                      signUpEmailController,
                      signUpPassWordController,
                      signUpPassWordController,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'SignUp',
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
                      'You have an account?',
                      style: GoogleFonts.rubik(
                        color: Constants.khakiMossColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text(
                        'Log In',
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

/// Validates user sign-up input fields and displays appropriate snack messages based on the validation results.
void userSignUpInputValidation(
    BuildContext context,
    TextEditingController signUpFirstNameController,
    TextEditingController signUpLastNameController,
    TextEditingController signUpEmailController,
    TextEditingController signUpPasswordController,
    TextEditingController signUpPassWordController) {
  // FirstName validation
  if (signUpFirstNameController.text.isEmpty ||
      signUpFirstNameController.text.length < 3) {
    brownSnak(context, 'Please Enter Your First Name ☹');
    // LastNAme validation
  } else if (signUpLastNameController.text.isEmpty ||
      signUpLastNameController.text.length < 3) {
    brownSnak(context, 'Please Enter Your Last Name ☹');
    // Email validation
  } else if (signUpEmailController.text.isEmpty ||
      !signUpEmailController.text.contains('@') ||
      !signUpEmailController.text.endsWith('.com')) {
    brownSnak(context, 'Please Enter Your Email ☹');
    // Password validation
  } else if (signUpPasswordController.text.isEmpty ||
      signUpPasswordController.text.length < 6) {
    brownSnak(context, 'Password is too weak ☹');
    // Successful validation
  } else {
    greenSnak(context, 'Creating Your Account🤗');
    // Delayed execution for signUpAndCreateUserAccount
    Future.delayed(Duration(seconds: 2), () {
      signUpAndCreateUserAccount(
        context,
        signUpFirstNameController,
        signUpLastNameController,
        signUpEmailController,
        signUpPassWordController,
      );
    });
  }
}

// This function signs up a new user, creates a Firestore user account with additional details
// and handles errors by deleting the account if creation fails.
Future signUpAndCreateUserAccount(
  BuildContext context,
  TextEditingController signUpFirstNameController,
  TextEditingController signUpLastNameController,
  TextEditingController signUpEmailController,
  TextEditingController signUpPassWordController,
) async {
  DocumentSnapshot<Map<String, dynamic>> userData;
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: signUpEmailController.text,
      password: signUpPassWordController.text,
    )
        .then((userCredential) async {
      if (userCredential.user != null) {
        print(userCredential.user!.uid);
        await userCredential.user
            ?.sendEmailVerification()
            .then((metaData) async {
          try {
            print('--- Saving to DB');
            await FirebaseFirestore.instance
                .collection('UserAccounts')
                .doc(userCredential.user?.uid)
                .set({
              'UserId': userCredential.user?.uid,
              'UserFirstName': signUpFirstNameController.text,
              'UserLastName': signUpLastNameController.text,
              'UserEmail': userCredential.user?.email,
              'AccountCreatedDateTime': DateTime.now(),
              'IsEmailVerified': false,
            }).then((value) async {
              print('--- Saved user to DB Successfully');
              userData = await FirebaseFirestore.instance
                  .collection('UserAccounts')
                  .doc(userCredential.user?.uid)
                  .get();
              print('--- Getting user from DB');
              print(userData.data());
            });
            signUpFirstNameController.clear();
            signUpLastNameController.clear();
            signUpEmailController.clear();
            signUpPassWordController.clear();
            await FirebaseAuth.instance.signOut();
            greenSnak(context, 'Verification Email Sent ✔');
            // Navigate to login screen after 2 seconds
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            });
          } catch (e) {
            FirebaseAuth.instance.currentUser?.delete().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) {
                print('Error occurred');
                redSnak(context, 'Error occurred');
              });
            });
          }
        });
      }
    });
  } on FirebaseAuthException catch (e) {
    print(e.message);
    redSnak(context, 'Error occurred');
  }
}
