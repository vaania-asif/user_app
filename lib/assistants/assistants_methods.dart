import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_app/assistants/request_assisstant.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/global/map_key.dart';
import 'package:user_app/models/user_model.dart';
import '../infoHandler/app_info.dart';
import '../models/directions.dart';
import 'package:http/http.dart' as http;

class AssistantMethods
{
  static Future<String> searchAddressForGeographicCoOrdinates(Position position, context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress="";

    var requestResponse = await RequestAssistant.recieveRequest(apiUrl);

    if(requestResponse != "Error Occurred")
    {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userDropoffAddress = Directions();
      userDropoffAddress.locationLatitude = position.latitude;
      userDropoffAddress.locationLongitude = position.longitude;
      userDropoffAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updateDropoffLocationAddress(userDropoffAddress);
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async
  {
    currentFirebaseUser = firebaseAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap)
    {
      if(snap.snapshot.value != null)
      {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<double> calculateAmount() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('price').get();
    if (snapshot.exists) {
      petrolPrice = snapshot.value as double?;
    }
    DatabaseReference price = FirebaseDatabase.instance.ref().child("price");

    double LitersRefuelled = 6;
    double totalAmount = petrolPrice! * LitersRefuelled;

    return double.parse(totalAmount.toStringAsFixed(1));
  }

  static sendNotificationToDriverNow(String deviceRegistrationToken, String userRideRequestId, context) async
  {
    String destinationAddress = userDropOffAddress;

    Map<String, String> headerNotification =
    {
      'Content-Type': 'application/json',
      'Authorization': cloudMessagingServerToken,
    };

    Map bodyNotification =
    {
      "body":"Destination Address: \n$destinationAddress.",
      "title":"New Trip Request"
    };

    Map dataMap =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "rideRequestId": userRideRequestId
    };

    Map officialNotificationFormat =
    {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": deviceRegistrationToken,
    };

    var responseNotification = http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }
}