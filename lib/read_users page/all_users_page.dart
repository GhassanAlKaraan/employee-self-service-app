import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_ess/read_users%20page/read%20data/user_card.dart';

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
            Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: Colors.red[900],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              // Build a listview from a future method.
              // Show loading indicator if data is still loading
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: UserCard(documentId: docIDs[index]),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
