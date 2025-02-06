import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {
  FirebaseMessage._();

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<NotificationSettings> getNotificationSettings() async {
    return await _firebaseMessaging.requestPermission();
  }

  static Future<void> getFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print("FCM Token: $token");
      } else {
        print("Failed to get FCM Token.");

      }
    } catch (error) {
      print("Error getting FCM Token: $error");
    }
  }



}

