import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_ess/read_leaves/components/read%20data/header_card.dart';
import '../utils/leaves_utils.dart';
import '../pages/leave_details_page.dart';

class LeaveHeadersPage extends StatefulWidget {
  const LeaveHeadersPage({super.key});

  @override
  State<LeaveHeadersPage> createState() => _LeaveHeadersPageState();
}

class _LeaveHeadersPageState extends State<LeaveHeadersPage> {
  //List of document IDs
  List<String> docIDs = [];

  // Flag to track whether data is being loaded
  bool isLoading = true;

  //Utilities
  final utility = Utility();

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
      utility.showSnackBar(context, "Couldn't load leaves");
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
        title: const Text("All Leave Requests:",
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
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                            onTap: () => utility.goToPage(context, LeaveDetailsPage(documentId: docIDs[index],)),
                            child:
                           HeaderCard(documentId: docIDs[index],),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
