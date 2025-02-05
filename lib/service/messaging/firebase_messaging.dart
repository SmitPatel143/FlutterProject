// import 'package:firebase_installations/firebase_installations.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FirebaseMessage {
//   FirebaseMessage._();
//
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   static Future<NotificationSettings> getNotificationSettings() async {
//     return await _firebaseMessaging.requestPermission();
//   }
//
//   static Future<String> getFCMToken() async {
//     try {
//       String? token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         print("FCM Token: $token");
//         return token;
//       } else {
//         print("Failed to get FCM Token.");
//         return "";
//       }
//     } catch (error) {
//       print("Error getting FCM Token: $error");
//       return "";
//     }
//   }
//
//   static void getFirebaseInstallationID() async {
//     String? fid = await FirebaseInstallations.id;
//     print("🔥 Firebase Installation ID: $fid");
//   }
//
//
// }
//
