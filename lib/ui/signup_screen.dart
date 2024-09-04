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
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'SignUp',
                    style: GoogleFonts.rubik(
                      color: Constants.primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/5.png',
                  height: 300,
                  width: 300,
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
                        signUpPassWordController);
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
    TextEditingController signUpPasswordController) {
  if (signUpFirstNameController.text.isEmpty ||
      signUpFirstNameController.text.length < 3) {
    brownSnak(context, 'Invalid First Name ☹');
  } else if (signUpLastNameController.text.isEmpty ||
      signUpLastNameController.text.length < 3) {
    brownSnak(context, 'Invalid Last Name ☹');
  } else if (signUpEmailController.text.isEmpty ||
      !signUpEmailController.text.contains('@') ||
      !signUpEmailController.text.endsWith('.com')) {
    brownSnak(context, 'Invalid Email ☹');
  } else if (signUpPasswordController.text.isEmpty ||
      signUpPasswordController.text.length < 6) {
    brownSnak(context, 'Invalid Password ☹');
  } else {
    greenSnak(context, 'Validation Completed 🤗');
  }
}
