import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/components/my_button.dart';
import 'package:new_ess/pages/all_users_page.dart';

import '../utilities/utility.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //utility
  final utility = Utility();

  //Get info about the user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //SIGN OUT method
    void firebaseLogout() {
      FirebaseAuth.instance.signOut();
    }

    void signOut() {
      utility.showAlertDialog(context, firebaseLogout, "Logout");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: user.displayName != null
            ? Text("Welcome ${user.displayName}")
            : Text("Welcome ${user.email}"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MyButton(
              onTap: () {
                utility.goToPage(context, const AllUsersPage());
              },
              txt: "See All Users",
            ),
          ],
        ),
      ),
    );
  }
}
