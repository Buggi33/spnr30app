import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spnr30app/components/my_firebase_file.dart';

//fetch firebase messaging to app
class FirebaseApiMessaging {
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

//fetch firebase store to app
class FirebaseApiGallery {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}
