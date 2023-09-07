import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/read%20data/get_user_name.dart';
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

  //List of document IDs
  List<String> docIDs = [];

  //DB READ: Get IDs and Fill the List
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
          }),
        );
  }

  // @override
  // void initState() {
  //   getDocIds();
  //   super.initState();
  // }

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
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              //const SizedBox(height: 20),
              const Text("Available Users:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              //const SizedBox(height: 20),
              Expanded(
                // Build a listview from a future.
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                tileColor: Colors.grey[300],
                                title: GetUserName(documentId: docIDs[index])),
                          );
                        });
                  },
                  future: getDocIds(),
                ),
              )
            ],
          ),
        ));
  }
}
