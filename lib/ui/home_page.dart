// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';
import 'package:plantio_app/ui/profile.dart';
import 'package:plantio_app/ui/scan_page.dart';
import 'dart:convert';
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

class HomePage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> userData;
  const HomePage({super.key, required this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                ),
              ),
              Divider(),
              Center(
                child: Text(
                  'Scan Your Plant',
                  style: GoogleFonts.merriweather(
                    fontSize: 25,
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
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
                        width: double.maxFinite,
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
            ],
          ),
        ));
  }

  Future uploadToFireBaseStorage() async {
    context.loaderOverlay.show();
    if (selectedImage != null) {
      try {
        var uploadTask = await FirebaseStorage.instance.ref().child('images/${selectedImage!.path.split('/').last}').putFile(selectedImage!);
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
    try {
      await uploadToFireBaseStorage();
      if (imageURl != 'NONE') {
        // Create to DB
        DocumentReference<Map<String, dynamic>> unprocessedImageDoc = await FirebaseFirestore.instance.collection('RecognizedPlants').add({
          'UserId': widget.userData.data()!['UserId'],
          'UnprocessedImageURL': imageURl,
          'Details': 'No details found',
          'Date': DateTime.now(),
        });
        // Decode Image to Base-64
        List<int> imageBytes = await selectedImage!.readAsBytes();
        var base64Image = base64Encode(imageBytes);
        print('ImageB64: $base64Image');

        // Predict Image
        await predictImage(base64Image).then((prediction) async {
          if (prediction != null) {
            if (prediction['result'] != null && prediction['result']['classification'] != null && prediction['result']['classification']['suggestions'] != null) {
              Map<String, dynamic> plantSuggestions = prediction['result']['classification']['suggestions'][0];
              // Apply Plant Search by Name
              await getImageSearch(plantSuggestions['name']).then((plantSearch) async {
                if (plantSearch != null) {
                  if (plantSearch['entities'] != null) {
                    await getImageSearchDetails(plantSearch['entities'][0]['access_token']).then((predictedPlantDetails) async {
                      if (predictedPlantDetails != null) {
                        unprocessedImageDoc.update({
                          'Details': predictedPlantDetails,
                        }).then((meta) async {
                          unprocessedImageDoc.get().then((predictedPlantDetails) {
                            context.loaderOverlay.hide();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.85, // 85% of the screen height
                                  child: PlantDetails(predictedImage: predictedPlantDetails),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                              ),
                            );
                          });
                        });
                      } else {
                        context.loaderOverlay.hide();
                        redSnak(context, 'No plant details found');
                      }
                    });
                  } else {
                    context.loaderOverlay.hide();
                    redSnak(context, 'No plant found in the image');
                  }
                }
              });
            } else {
              context.loaderOverlay.hide();
              redSnak(context, 'No plant found in the image');
            }
          } else {
            context.loaderOverlay.hide();
            redSnak(context, 'Image Cannot be predicted ☹️');
          }
        });
      } else {
        context.loaderOverlay.hide();
        redSnak(context, 'Error occurred while processing image');
      }
    } catch (e) {
      context.loaderOverlay.hide();
      redSnak(context, 'Error occurred while processing image');
    }
  }

  Future<Map<String, dynamic>?> predictImage(String imageUrlB64) async {
    var headers = {
      'Content-Type': 'application/json',
      'Api-Key': '4LdLuJXhFGTSRTgJgkKJj3WfUh0QO9EyqtIhb1R2Qjr1bUa1mX'
    };
    var data = {
      'images': [
        'data:image/png;base64,$imageUrlB64'
      ],
      'similar_images': true
    };
    var dio = Dio();
    var response = await dio.request(
      'https://plant.id/api/v3/identification',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response);

    if (response.statusCode == 201) {
      print(response.data);
      return response.data;
    } else {
      print(response.statusMessage);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getImageSearch(String imageName) async {
    var headers = {
      'Api-Key': '4LdLuJXhFGTSRTgJgkKJj3WfUh0QO9EyqtIhb1R2Qjr1bUa1mX'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://plant.id/api/v3/kb/plants/name_search?q=$imageName&limit=1',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.statusMessage);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getImageSearchDetails(String plantAccessToken) async {
    var headers = {
      'Api-Key': '4LdLuJXhFGTSRTgJgkKJj3WfUh0QO9EyqtIhb1R2Qjr1bUa1mX'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://plant.id/api/v3/kb/plants/$plantAccessToken?details=common_names,url,description,taxonomy,rank,gbif_id,inaturalist_id,image,synonyms,edible_parts,watering,propagation_methods',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.statusMessage);
      return null;
    }
  }
}
