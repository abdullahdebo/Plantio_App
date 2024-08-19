// ignore_for_file: unused_import, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
    navigatorAfterDuration();
    super.initState();
  }

// This Function For Delayed The Splash Screen After That We are Going To OnboardingScreen
  void navigatorAfterDuration() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => OnboardingScreen()));
    });
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
