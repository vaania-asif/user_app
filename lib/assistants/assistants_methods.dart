import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_app/assistants/request_assisstant.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/global/map_key.dart';
import 'package:user_app/models/user_model.dart';
import '../infoHandler/app_info.dart';
import '../models/directions.dart';

class AssistantMethods
{
  static Future<String> searchAddressForGeographicCoOrdinates(Position position, context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress="";

    var requestResponse = await RequestAssistant.recieveRequest(apiUrl);

    if(requestResponse != "Error Occurred, Failed. No Response.")
    {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updateDropoffLocationAddress(userPickUpAddress);
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

  static double calculateAmount(){
    double petrolPricePerLiter = 224.40;
    double LitersRefuelled = 6;
    double totalAmount = petrolPricePerLiter*LitersRefuelled;

    return double.parse(totalAmount.toStringAsFixed(1));
  }
}