import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'read data/get_user_name.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  //List of document IDs
  List<String> docIDs = [];

  //TODO - manage - Firestore READ: Get IDs and Fill the List
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('users').orderBy('name', descending: true).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Users:",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              // Build a listview from a future.
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
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
      ),
    );
  }
}
