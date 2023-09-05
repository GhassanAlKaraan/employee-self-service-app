import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/utility.dart';

class HomePage extends StatelessWidget {
  //utility
  final utility = Utility();

  //Get info about the user
  final user = FirebaseAuth.instance.currentUser!;


  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //SIGN OUT method
    void firebaseLogout(){FirebaseAuth.instance.signOut();}
    void signOut() {utility.showAlertDialog(context, firebaseLogout, "Logout?");}

    return Scaffold(
      appBar: AppBar(
        title: Text("User Authenticated: " + user.email.toString()),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
