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
      //Finally, Sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }
}
