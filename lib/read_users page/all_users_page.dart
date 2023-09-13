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

  // Flag to track whether data is being loaded
  bool isLoading = true;

  //TODO - manage - Firestore READ: Get IDs and Fill the List
  Future<void> getDocIds() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('name', descending: true)
          .get();

      docIDs.clear(); // Clear the list before adding new data
      snapshot.docs.forEach((document) {
        docIDs.add(document.reference.id);
      });
    } catch (e) {
      // Handle errors here if needed
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false; // Data loading is complete
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDocIds(); // Start loading data when the widget is initialized
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
              // Build a listview from a future method.
              // Show loading indicator if data is still loading
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                              tileColor: Colors.grey[300],
                              title:
                                  GetUserName(documentId: docIDs[index])),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
