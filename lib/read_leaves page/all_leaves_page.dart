import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'read data/get_leave_header.dart';

class AllLeavesPage extends StatefulWidget {
  const AllLeavesPage({super.key});

  @override
  State<AllLeavesPage> createState() => _AllLeavesPageState();
}

class _AllLeavesPageState extends State<AllLeavesPage> {
  //List of document IDs
  List<String> docIDs = [];

  // Flag to track whether data is being loaded
  bool isLoading = true;

  Future<void> getDocIds() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('leave header')
          .orderBy('leave id', descending: false)
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
        title: const Text("Leaves pending approval:",
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
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.grey[300]),
                              child: GetLeaveId(documentId: docIDs[index])),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
