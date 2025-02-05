import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
      {required String email,
      required String password,
      required Function(User) onSuccess,
      required Function(String) onError}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      onSuccess(userCredential.user!);
    } on FirebaseAuthException catch (error) {
      onError(error.code);
    } catch (error) {
      onError("Technical Error, Please try again later");
    }
  }

  //SignIn with google
  Future<void> signInWitGoogle(
      {required Function(User) onSuccess,
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
      onSuccess(user!);
    } catch (error) {
      printError(info: error.toString());
      onError("Technical Error, please try again later");
    }
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
