import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_ess/read_leaves%20page/details_page_example.dart';
import 'package:new_ess/read_leaves%20page/read_leaves%20utilities/utility.dart';

class LeaveDetailsPage extends StatefulWidget {
  LeaveDetailsPage({super.key, required this.documentId});

  final documentId;

  @override
  State<LeaveDetailsPage> createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  // Flag to track whether data is being loaded
  bool isLoading = true;

  final utility = Utility();

  Map<String, dynamic>? myData; // Declare a variable to store the data

  Future<Map<String, dynamic>?> getData(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('leave details')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        return data;
      } else {
        utility.showSnackBar(context, "No Details for this leave!");
        return null;
      }
    } catch (e) {
      utility.showSnackBar(context, e.toString());
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // Call getData and update myData when data is fetched
    getData(widget.documentId).then((data) {
      setState(() {
        myData = data; // Update myData with the fetched data
        isLoading = false; // Set isLoading to false
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Leave details:",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child:
                      //TODO: insert custom card widget here - use wrap...
                      //     Text(
                      //   "Employee: ${myData?['employee first name']}",
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //   ),
                      // ),
                      DetailsPageExample(),
                ),
        ),
      ),
    );
  }
}
