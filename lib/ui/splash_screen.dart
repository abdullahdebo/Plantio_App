// ignore_for_file: unused_import, override_on_non_overriding_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plantio_app/ui/home_page.dart';
import 'package:plantio_app/ui/onboarding_screen.dart';
import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateAfterDuration();
    super.initState();
  }

//This function checks Firebase for a logged-in user; if found, it navigates to HomePage; otherwise, it directs to OnboardingScreen.
  void navigateAfterDuration() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null && user.uid.isNotEmpty == true) {
      Future.delayed(Duration(seconds: 4), () async {
        await FirebaseFirestore.instance
            .collection('UserAccounts')
            .doc(user.uid)
            .get()
            .then((userDoc) async {
          if (userDoc.id.isNotEmpty == true &&
              userDoc.data()?.isNotEmpty == true) {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (BuildContext context) =>
                    HomePage(userData: userDoc)));
          } else {
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => OnboardingScreen()));
            });
          }
        });
      });
    } else {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => OnboardingScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blanketColor,
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              child: Image.asset('assets/images/splash-screen.png'),
            ),
            Text(
              'Plantio App',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                color: Constants.primaryColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),

            //Here The loading_indicator dependencie
            LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [
                Constants.primaryColor,
              ],
              strokeWidth: 3,
              backgroundColor: Constants.blanketColor,
              pathBackgroundColor: Constants.primaryColor,
            ),

            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                'Loading ...',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  color: Constants.primaryColor,
                  letterSpacing: 3,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
