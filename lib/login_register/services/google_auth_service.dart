import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  // Google sign in method
  signInWithGoogle() async {
    try {
      //Launch interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      //Get auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      //Create new credentials for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //Save name and email to firestore
      addUserDetails(gUser.displayName.toString(), gUser.email);


      //Finally, Sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  // TODO - manage - FIRESTORE CRUD: add data to firestore
  Future<void> addUserDetails(String name, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
      });
    } catch (e) {
      print("LOGIN ERROR ----- GOOGLE ");
    }
  }

}
