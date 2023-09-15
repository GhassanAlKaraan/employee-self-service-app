import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class GetLeaveId extends StatelessWidget {
  GetLeaveId({super.key, required this.documentId});

  //We have the document id, we need to retrieve the user's name.

  final String documentId;

  @override
  Widget build(BuildContext context) {
    //Get the collection
    CollectionReference leaves = FirebaseFirestore.instance.collection("leave header");

    return FutureBuilder<DocumentSnapshot>(
        future: leaves.doc(documentId).get(),
        builder: ((context, snapshot) {
          //Check if the connection is established
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            Timestamp creationDateTimestamp = data['creation date'];
            DateTime creationDateDateTime = creationDateTimestamp.toDate();
            String formattedCreationDate = DateFormat('yyyy-MM-dd')
                .format(creationDateDateTime);
            // String formattedCreationDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            //     .format(creationDateDateTime);

            return Text(
              "Leave ID: ${data['leave id']}, \nCreation Date: $formattedCreationDate",
              style: const TextStyle(
                fontSize: 18,
              ),
            );
          } else {
            return const Text("Loading...");
          }
        }));
  }
}
