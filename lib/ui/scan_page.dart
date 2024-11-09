import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:plantio_app/constants.dart';
import 'package:plantio_app/snackBar.dart';
import 'package:plantio_app/ui/plant_details.dart';

class ScanPage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> userData;
  const ScanPage({super.key, required this.userData});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // Picks an image from the specified source and updates the selectedImage state if successful.
  File? selectedImage;
  String imageURl = 'NONE';

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
    return LoaderOverlay(
      child: Scaffold(
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
                  height: 300,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                              fit: BoxFit.contain,
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
                      onPressed: () async {
                        context.loaderOverlay.show();
                        await processImage();
                        context.loaderOverlay.hide();
                      },
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
      ),
    );
  }

  Future uploadToFireBaseStorage() async {
    context.loaderOverlay.show();
    if (selectedImage != null) {
      try {
        var uploadTask = await FirebaseStorage.instance
            .ref()
            .child('images/${selectedImage!.path.split('/').last}')
            .putFile(selectedImage!);
        var downloadUrl = await uploadTask.ref.getDownloadURL();
        print('File uploaded to: $downloadUrl');
        setState(() {
          imageURl = downloadUrl;
        });
      } catch (e) {
        // context.loaderOverlay.hide();
        context.loaderOverlay.hide();
        print(e);
      }
    } else {
      context.loaderOverlay.hide();
      // context.loaderOverlay.hide();
      print('No image selected.');
    }
  }

  Future processImage() async {
    context.loaderOverlay.show();
    // context.loaderOverlay.show();
    try {
      await uploadToFireBaseStorage();
      if (imageURl != 'NONE') {
        // Create to DB
        DocumentReference<Map<String, dynamic>> unprocessedImageDoc =
            await FirebaseFirestore.instance
                .collection('RecognizedPlants')
                .add({
          'UserId': widget.userData.data()!['UserId'],
          'UnprocessedImageURL': imageURl,
          'Confidence': 0.0,
          'Tag': null,
          'Details': 'No details found',
          'Date': DateTime.now(),
        });
        // Fire API call and collect the best confidence value
        await predictImage(
                'https://m.media-amazon.com/images/I/61HCpPU1P7L._AC_UF1000,1000_QL80_.jpg')
            .then((listTag) {
          if (listTag.isNotEmpty) {
            // Re-save the name of the plant
            unprocessedImageDoc.update({
              'Tag': listTag[0]['tag'],
              'Confidence': listTag[0]['confidence']
            }).then((meta) async {
              // Fire 2nd API call to collect the plant details
              await getImageDetails(listTag[0]['tag']).then((imageDetails) {
                if (imageDetails != null) {
                  unprocessedImageDoc
                      .update({'Details': imageDetails}).then((meta) {
                    greenSnak(context, 'Plant recognized successfully 👌');
                    setState(() {
                      selectedImage = null;
                      imageURl = 'NONE';
                    });
                  });
                  unprocessedImageDoc.get().then((imageDetails) {
                    context.loaderOverlay.hide();
                    // context.loaderOverlay.hide();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlantDetails(proccessed_image: imageDetails),
                      ),
                    );
                  });
                } else {
                  context.loaderOverlay.hide();
                  // context.loaderOverlay.hide();
                  unprocessedImageDoc.delete().then((meta) {
                    redSnak(context, 'No recognized plants found ');
                    setState(() {
                      selectedImage = null;
                      imageURl = 'NONE';
                    });
                  });
                }
              });
            });
          } else {
            // context.loaderOverlay.hide();
            // Delete the unprocessed image and remove the variable values
            unprocessedImageDoc.delete().then((meta) {
              redSnak(context, 'No recognized plants found');
              setState(() {
                selectedImage = null;
                imageURl = 'NONE';
              });
            });
          }
        });
      } else {
        context.loaderOverlay.hide();
        // context.loaderOverlay.hide();
        redSnak(context, 'Error occurred while processing image');
      }
    } catch (e) {
      context.loaderOverlay.hide();
      // context.loaderOverlay.hide();
      redSnak(context, 'Error occurred while processing image');
    }
  }

  Future<List<dynamic>> predictImage(String imageUrl) async {
    var headers = {
      'Authorization':
          'Basic YWNjXzRiZDY3MzFmNDAyYjViODpmZjEwM2M5Y2U1Yzg4YWY3NWY2YjljNDQ2ZWFkM2MwMQ=='
    };
    var dio = Dio();
    var response = await dio.request(
      'https://api.imagga.com/v2/tags?image_url=$imageUrl',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      var tags = response.data['result']['tags'];
      // Sort tags by confidence in descending order, with explicit casting
      tags.sort(
          (a, b) => (b['confidence'] as num).compareTo(a['confidence'] as num));
      // Extract the top 1 tags with their confidence and "en" tag
      var topTags = tags.take(1).map((tag) {
        return {
          'confidence': tag['confidence'],
          'tag': tag['tag']['en'],
        };
      }).toList();
      print(topTags);
      return topTags;
    } else {
      print(response.statusMessage);
      return [];
    }
  }

  Future getImageDetails(String tagName) async {
    var dio = Dio();
    var response = await dio.request(
      'https://trefle.io/api/v1/plants?token=jxyYWiMGOndlJAs9EVbEaciEIXKEuL-_kYySsKFgm6s&filter[common_name]=$tagName',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['data'].isNotEmpty) {
        return response.data['data'][0];
      } else {
        return null;
      }
    } else {
      print(response.statusMessage);
    }
  }
}
