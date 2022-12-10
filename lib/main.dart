

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/infoHandler/app_info.dart';
//import 'package:user_app/infoHandler/app_info.dart';
import 'package:user_app/splashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(
        child: ChangeNotifierProvider(
          create: (context) => AppInfo(),
          child: MaterialApp(
              title: 'User app',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const MySplashScreen()
          ),
        ),
      ),

  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  MyApp({this.child});

  //to restart the app and initialize all variables from the start
  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}