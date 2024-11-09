import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantio_app/constants.dart';
import 'package:plantio_app/ui/login_screen.dart';

class Profile extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> userData;

  const Profile({super.key, required this.userData});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final DocumentSnapshot<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blanketColor,
      appBar: AppBar(
        backgroundColor: Constants.blanketColor,
        foregroundColor: Constants.autumnFernColor,
        title: Text(
          'Profile',
          style: GoogleFonts.merriweather(
            fontSize: 35,
            color: Constants.autumnFernColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg'),
            ),
            SizedBox(height: 20),

            // Username with icon and custom style
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Constants.autumnFernColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  userData.data()?['UserFirstName']?.toString() ?? 'User',
                  style: GoogleFonts.merriweather(
                    fontSize: 28,
                    color: Constants.autumnFernColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // User email with icon and custom style
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  color: Constants.autumnFernColor,
                  size: 25,
                ),
                SizedBox(width: 10),
                Text(
                  userData.data()?['UserEmail']?.toString() ??
                      'Email not available',
                  style: GoogleFonts.merriweather(
                    fontSize: 18,
                    color: Constants.autumnFernColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: Constants.autumnFernColor,
              ),
              onPressed: () {
                signOut(context);
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.merriweather(
                  fontSize: 21,
                  color: Constants.blanketColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
