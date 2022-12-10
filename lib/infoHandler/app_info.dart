import 'package:flutter/foundation.dart';
import 'package:user_app/models/directions.dart';

class AppInfo extends ChangeNotifier{
  Directions? userDropoffLocation;

  void updateDropoffLocationAddress(Directions userDropoffAddress){
    userDropoffLocation = userDropoffAddress;
    notifyListeners();
  }

}