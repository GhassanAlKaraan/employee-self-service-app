import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:new_ess/read_leaves/components/read%20data/details_card.dart';
import '../components/write data/details_buttons.dart';
import '../services/notification_service.dart';
import '../utils/leaves_utils.dart';

class LeaveDetailsPage extends StatefulWidget {
  const LeaveDetailsPage({super.key, required this.documentId});

  final String documentId; // Same as leave id

  @override
  State<LeaveDetailsPage> createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  // Flag to track whether data is being loaded
  bool isLoading = true;
  bool isApproved = false;

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

  String convertFromDate(Map<String, dynamic> myData) {
    Timestamp fromDateTimestamp = myData['from date'];
    DateTime fromDateDateTime = fromDateTimestamp.toDate();
    String formattedFromDate =
        DateFormat('yyyy-MM-dd').format(fromDateDateTime);

    return formattedFromDate;
  }

  String convertToDate(Map<String, dynamic> myData) {
    Timestamp toDateTimestamp = myData['to date'];
    DateTime toDateDateTime = toDateTimestamp.toDate();
    String formattedToDate = DateFormat('yyyy-MM-dd').format(toDateDateTime);

    return formattedToDate;
  }

  double calculateTotalDays(Map<String, dynamic> myData) {
    Timestamp toDateTimestamp = myData['to date'];
    DateTime toDateDateTime = toDateTimestamp.toDate();

    Timestamp fromDateTimestamp = myData['from date'];
    DateTime fromDateDateTime = fromDateTimestamp.toDate();

    Duration difference = toDateDateTime.difference(fromDateDateTime);

    double differenceInDays = difference.inSeconds / 86400.0;

    return differenceInDays;
  }

  //Notifications
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    //Notifications
    notificationService.initializeNotifications();

    // Call getData and update myData when data is fetched
    getData(widget.documentId).then((data) {
      setState(() {
        myData = data; // Update myData with the fetched data
        isLoading = false; // Set isLoading to false
        isApproved = myData!['approved'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  child: Column(
                    children: [
                      DetailsCard(
                        toDate: convertToDate(myData!),
                        leaveId: widget.documentId,
                        empFirstName: myData!['employee first name'],
                        isExpired: myData!['expired'],
                        validBalance: myData!['valid balance'],
                        fromDate: convertFromDate(myData!),
                        leaveReason: myData!['reason'],
                        isApproved: myData!['approved'],
                        leaveType: myData!['type'],
                        totalDays: calculateTotalDays(myData!),
                      ),
                      const SizedBox(height: 40),
                      DetailsButtons(
                        notificationService: notificationService,
                        isExpired: myData!['expired'],
                        isApproved: isApproved,
                        documentId: widget.documentId,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
