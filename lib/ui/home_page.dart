import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required DocumentSnapshot<Map<String, dynamic>> userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blanketColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'HOME PAGE 😊',
              style: GoogleFonts.rubik(
                fontSize: 50,
                color: Constants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
