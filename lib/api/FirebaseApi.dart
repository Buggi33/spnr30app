import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
// create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

//function to initialize notifications
  Future<String?> initNotificationsAndGetToken() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    String? fcmToken = await _firebaseMessaging.getToken();
    //return the token
    // print('Token: ' + fcmToken.toString());
    return fcmToken;
  }
}
