import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //contains driver key
String? chosenDriverId = "";
String cloudMessagingServerToken = "AAAA7u3j5_I:APA91bFf--b8uhPm9Kp45HQSPM-o6bxd829oKgy8ow7hMgDDiWB4dXIUPkXY3fT7fqohtLqPUDCppUmowehRUkgv7NswMsmb746YicQrnlk3OcP3Vl7kPqom4et25IvXf_eeeV5gSyEz";
String userDropOffAddress = "";
String driverCarDetails = "";
String driverPhone = "";
String driverName = "";