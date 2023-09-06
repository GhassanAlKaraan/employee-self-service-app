import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  //Get IDs and Fill the List
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
          backgroundColor: Colors.transparent,
          title: Text("User Authenticated: ${user.email}"),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(docIDs[index]),
                        );
                      });
                },
                future: getDocIds(),
              ),
            )
          ],
        ));
  }
}
