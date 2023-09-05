import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  // Google sign in method
  signInWithGoogle() async{
    //Launch interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //Get auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //Create new credentials for the user
    final credential  = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,);
    //Finally, Sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );


  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}