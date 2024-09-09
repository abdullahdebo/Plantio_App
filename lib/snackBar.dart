import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';

// This function displays a green SnackBar with a rounded border and custom text style.
greenSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

// This function displays a red SnackBar with a rounded border and custom text style.
redSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

// This function displays a brown SnackBar with a rounded border and custom text style.
brownSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.autumnFernColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Constants.blanketColor,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

// This function displays a blue SnackBar with a rounded border and custom text style.
blueSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

// This function displays a orange SnackBar with a rounded border and custom text style.
orangeSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

// This function displays a green SnackBar with a rounded border and custom text style.
blackSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

// This function displays a purple SnackBar with a rounded border and custom text style.
purplekSnak(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 3),
    elevation: 0,
    content: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}
