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

      //Optional: Save name and email to firestore
      addUserDetails(gUser.displayName.toString(), gUser.email);

      //Finally, Sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addUserDetails(String name, String email) async {
    try {
      // It sets document ID as email to prevent duplicates
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'verified email': true, //because Google Authentication is always verified
      });

    } catch (e) {
      print("Firestore connection ERROR --- GOOGLE ");
    }
  }

}
