import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/models/user/user_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final db = FirebaseFirestore.instance;
  final logger = Logger();

  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return user;
    } catch (e) {
      logger.printError(info: e.toString());
      return null;
    }
  }

  //signIn with email and password
  Future<User?> logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (error) {
      printError(info: error.toString());
      return null;
    }
  }

  //Register with email and password
  Future<void> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password,
      required Function(String) onSuccess,
      required Function(String) onError}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;
      if (user == null) throw 'User creation failed';

      await _saveUserInfo(user, name);
      onSuccess("Registration done");
    } on FirebaseAuthException catch (error) {
      onError(error.code);
    } catch (error) {
      onError("Technical Error, Please try again later");
    }
  }

  //SignIn with google
  Future<void> signInWithGoogle(
      {required Function(String) onSuccess,
      required Function(String) onError}) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user == null) throw 'User creation failed';
      _saveUserInfo(user, null);
      onSuccess("Registration successfully");
    } catch (error) {
      printError(info: error.toString());
      onError("Technical Error, please try again later");
    }
  }

  //sign in with microsoft
  Future<void> signInWithMicrosoft(
      {required Function onSuccess, required Function onError}) async {
    try {
      final microsoftProvider = MicrosoftAuthProvider();
      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithPopup(microsoftProvider);
      } else {
        await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
      }
      onSuccess();
    } catch (error) {
      onError(error);
    }
  }

  //save user info
  Future<void> _saveUserInfo(User? user, String? name) async {
    try {
      if (user != null) {
        await db
            .collection("UserDetails")
            .doc(user.uid)
            .set(_generateUserDetails(user, name));
      } else {
        printError(info: "user is null");
      }
    } catch (error) {
      printError(info: error.toString());
    }
  }

  //update user info
  Future<void> updateUserInfo(String uid, UserDetails userDetails) async {
    try {
      final User? user = getCurrentUser();
      if (user != null) {
        await db
            .collection("UserDetails")
            .doc(uid)
            .update(_generateUserDetails(user, userDetails.name));
        await _auth.currentUser!.updateProfile(
            displayName: userDetails.name, photoURL: userDetails.photoUrl);
      } else {
        printError(info: "user is null");
      }
    } catch (error) {
      printError(info: error.toString());
    }
  }

  //update user password
  Future<void> updateUserPassword(String password) async {
    try {
      final User? user = getCurrentUser();
      if (user != null) {
        await user.updatePassword(password);
      } else {
        printError(info: "user is null");
      }
    } catch (error) {
      printError(info: error.toString());
    }
  }

  //update user email
  Future<void> updateUserEmail(String email) async {
    try {
      printInfo(info: "Inside the update user email");
      final User? user = getCurrentUser();
      if (user != null) {
        var emailUpdateResult = await user.verifyBeforeUpdateEmail(email);
      } else {
        printError(info: "user is null");
      }
    } catch (error) {
      printError(info: error.toString());
    }
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //create user object
  Map<String, dynamic> _generateUserDetails(User user, String? name) {
    return UserDetails(
      uid: user.uid,
      name: user.displayName ?? name,
      email: user.email,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    ).toJson();
  }

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
