import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/verify_email_page.dart';
import 'login_or_register.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Listen to FirebaseAuth's stream
        stream: FirebaseAuth.instance.authStateChanges(),
        // to build something
        builder: (context, snapshot){
          // Check if there is data using the snapshot

          //user logged in
          if(snapshot.hasData){
            return const VerifyEmailPage();
            //return HomePage();
          }
          //user not logged in
          else{
            return const LoginOrRegister();

          }
        },
      ),
    );
  }
}