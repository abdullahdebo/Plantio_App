import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantio_app/constants.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  //// Picks an image from the specified source and updates the selectedImage state if successful.
  File? selectedImage;
  Future getImageFrom(BuildContext context, ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Your Plant',
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
        child: Padding(
          padding: EdgeInsets.only(top: 130, left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 275,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Constants.khakiMossColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: selectedImage == null
                        ? Icon(
                            Icons.add_a_photo,
                            size: 75,
                            color: Constants.kimberColor,
                          )
                        : Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )),
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Constants.khakiMossColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    getImageFrom(context, ImageSource.camera);
                  },
                  child: Text(
                    'Take Photo From Camera',
                    style: GoogleFonts.rubik(
                      fontSize: 17,
                      color: Constants.blanketColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Constants.khakiMossColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    getImageFrom(context, ImageSource.gallery);
                  },
                  child: Text(
                    'Upload Photo From Gallery',
                    style: GoogleFonts.rubik(
                      fontSize: 17,
                      color: Constants.blanketColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Click Here To Scan Your Plant 😏',
                      style: GoogleFonts.rubik(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
