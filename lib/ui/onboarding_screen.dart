// ignore_for_file: unused_field, unused_import, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';

import 'login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //Declare The PageController
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blanketColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Constants.blanketColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                //changed Later on To pushREblesment
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Login()));
              }, //To Login Screen
              child: Text(
                'Skip',
                style: GoogleFonts.rubik(
                  color: Constants.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              //Page Number 1
              Container(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                      child: Image.asset('assets/images/1.png'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Learn More About Plants',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Constants.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Read How To Care For Plants In Our Rich Plants Guide',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Constants.khakiMossColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              //Page Number 2
              Container(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                      child: Image.asset('assets/images/2.png'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Find a plant lover friend',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Constants.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Are you a plant lover? Connect with other plant lovers',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Constants.khakiMossColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              //Page Number 3
              Container(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                      child: Image.asset('assets/images/3.png'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Plant a tree, green the Earth',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Constants.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Find almost all types of plants that you like here',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Constants.khakiMossColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Constants.mushroomColor),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex < 2) {
                      currentIndex++;
                      if (currentIndex < 3) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    } else {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Login()));
                    }
                  });
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Constants.primaryColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create The Indicator Decoration
  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

// Create The Indicator List
  List<Widget> buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(indicator(true));
      } else {
        indicators.add(indicator(false));
      }
    }
    return indicators;
  }
}
