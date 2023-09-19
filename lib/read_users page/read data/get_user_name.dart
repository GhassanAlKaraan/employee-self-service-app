import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  GetUserName({super.key, required this.documentId});

  //We have the document id, we need to retrieve the user's name.

  final String documentId;

  @override
  Widget build(BuildContext context) {
    //Get the collection
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot) {
          //Check if the connection is established
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Row(
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                  "${data['name']}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            );
          } else {
            return const Text("Loading...");
          }
        }));
  }
}
