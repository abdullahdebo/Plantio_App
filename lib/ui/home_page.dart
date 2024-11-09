// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';
import 'package:plantio_app/ui/profile.dart';
import 'package:plantio_app/ui/scan_page.dart';

class HomePage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> userData;
  const HomePage({super.key, required this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.blanketColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 85,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Wellcome!',
                            style: GoogleFonts.merriweather(
                              fontSize: 25,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.userData.data()!['UserFirstName'].toString(),
                            style: GoogleFonts.merriweather(
                              fontSize: 19,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.search,
                          //     color: Constants.primaryColor,
                          //     size: 37,
                          //   ),
                          //   onPressed: () {},
                          // ),
                          IconButton(
                            icon: Icon(
                              Icons.person,
                              color: Constants.primaryColor,
                              size: 37,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Profile(
                                    userData: widget.userData,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Scan button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ScanPage(
                          userData: widget.userData,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Scan / Upload Plant',
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.blanketColor,
                            ),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Constants.blanketColor,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '🔥 Fire Hit Plant:',
                style: GoogleFonts.merriweather(
                  fontSize: 21,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 250,
                width: double.maxFinite,
                // color: Colors.red,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '⚡ Recent Predictions:',
                style: GoogleFonts.merriweather(
                  fontSize: 21,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 275,
                width: double.maxFinite,
                // color: Colors.red,
              )
            ],
          ),
        ));
  }
}
