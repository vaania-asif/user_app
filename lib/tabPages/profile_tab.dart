
import 'package:flutter/material.dart';
import 'package:user_app/splashScreen/splash_screen.dart';

import '../global/global.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override

  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text(
            'sign out'
        ),
        onPressed: () {
          firebaseAuth.signOut();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => MySplashScreen()),
          );
        },
      ),
    );
  }
}
