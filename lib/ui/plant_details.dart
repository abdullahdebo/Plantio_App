import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plantio_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> predictedImage;
  const PlantDetails({super.key, required this.predictedImage});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool askGPT = true;

  final List<String> mapUrls = [
    'https://maps.app.goo.gl/e6hkwwBSGZKJiSFn9?g_st=com.google.maps.preview.copy',
    'https://maps.app.goo.gl/RXmjDbqTZk4UNmZz9?g_st=com.google.maps.preview.copy',
    'https://maps.app.goo.gl/aJqBkVjrpQJydmUe8?g_st=com.google.maps.preview.copy',
    'https://maps.app.goo.gl/jgBk8x5T3Jd4fN399?g_st=com.google.maps.preview.copy',
  ];

  void openRandomDirection() {
    final random = Random();
    final randomUrl = mapUrls[random.nextInt(mapUrls.length)];
    launchURL(randomUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blanketColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.predictedImage.data()!['UnprocessedImageURL'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.predictedImage.data()!['Details']['name'].toString(),
                    style: GoogleFonts.merriweather(
                      fontSize: 25,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '   ${widget.predictedImage.data()!['Details']['rank']}',
                    style: GoogleFonts.merriweather(
                      fontSize: 17,
                      color: Constants.primaryColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Table(
                border:
                    TableBorder.all(color: Constants.primaryColor, width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(2),
                },
                children: [
                  _buildTableRow(
                      'Family:',
                      widget.predictedImage.data()!['Details']['taxonomy']
                          ['family']),
                  _buildTableRow(
                      'Class:',
                      widget.predictedImage.data()!['Details']['taxonomy']
                          ['class']),
                  _buildTableRow(
                      'Genus:',
                      widget.predictedImage.data()!['Details']['taxonomy']
                          ['genus']),
                  _buildTableRow(
                      'Kingdom:',
                      widget.predictedImage.data()!['Details']['taxonomy']
                          ['kingdom']),
                  _buildTableRow(
                      'Order:',
                      widget.predictedImage.data()!['Details']['taxonomy']
                          ['order']),
                  _buildTableRow(
                      'Phylum:',
                      widget.predictedImage.data()!['Details']['taxonomy']
                          ['phylum']),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Want more information ? ',
                style: GoogleFonts.merriweather(
                  fontSize: 20,
                  color: Constants.primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: !askGPT,
                child: Text(
                  'Provide more information on ${widget.predictedImage.data()!['Details']['name']} ${widget.predictedImage.data()!['Details']['rank']} with at least 100 words.',
                  style: GoogleFonts.merriweather(
                    fontSize: 18,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                child: Container(
                  height: 45,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          askGPT == true
                              ? 'Generate message for ChatGPT  '
                              : 'Go to ChatGPT',
                          style: GoogleFonts.merriweather(
                            fontSize: 19,
                            color: Constants.blanketColor,
                          ),
                        ),
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedChatGpt,
                          color: Constants.blanketColor,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  setState(() {
                    askGPT = false;
                  });
                  Clipboard.setData(ClipboardData(
                      text:
                          'Provide more information on ${widget.predictedImage.data()!['Details']['name']} ${widget.predictedImage.data()!['Details']['rank']} with at least 100 words.'));
                  launchURL('https://chatgpt.com/');
                },
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: openRandomDirection,
                child: Container(
                  height: 45,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Constants.kimberColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Open the directions',
                          style: GoogleFonts.merriweather(
                            fontSize: 19,
                            color: Constants.blanketColor,
                          ),
                        ),
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedGoogleMaps,
                          color: Constants.blanketColor,
                          size: 28.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                child: Container(
                  height: 45,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Constants.autumnFernColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedCancelSquare,
                          color: Constants.blanketColor,
                          size: 28.0,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Close Prediction Sheet',
                          style: GoogleFonts.merriweather(
                            fontSize: 19,
                            color: Constants.blanketColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: GoogleFonts.merriweather(
              fontSize: 20,
              color: Constants.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: GoogleFonts.merriweather(
              fontSize: 19,
              color: Constants.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
