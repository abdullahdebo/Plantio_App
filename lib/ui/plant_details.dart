import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';

class PlantDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> proccessed_image;
  const PlantDetails({super.key, required this.proccessed_image});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Constants.primaryColor,
        title: Text(
          'Plant Details',
          style: GoogleFonts.merriweather(
            fontSize: 25,
            color: Constants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.blanketColor,
      ),
      backgroundColor: Constants.blanketColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.proccessed_image.data()!['UnprocessedImageURL'],
                  height: 450,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.blanketColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.proccessed_image
                            .data()!['Tag']
                            .toString()
                            .toUpperCase(),
                        style: GoogleFonts.merriweather(
                          fontSize: 25,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Confidence: ${widget.proccessed_image.data()!['Confidence'].toStringAsFixed(2)}%',
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: Constants.primaryColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            'Family: ',
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.proccessed_image.data()!['Details']
                                ['family'],
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Rank: ',
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.proccessed_image.data()!['Details']['rank'],
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Scientific Name: ',
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.proccessed_image.data()!['Details']
                                ['scientific_name'],
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Year: ',
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.proccessed_image
                                .data()!['Details']['year']
                                .toString(),
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Bibliography: ',
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.proccessed_image
                                .data()!['Details']['bibliography']
                                .toString(),
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
