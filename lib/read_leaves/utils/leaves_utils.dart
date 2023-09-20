import 'package:flutter/material.dart';

class Utility {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3), // Optional: Set the duration
        action: SnackBarAction(label: 'Close', onPressed: () {}),
      ),
    );
  }

  Future<void> showAlertDialog(
      BuildContext context, VoidCallback customFunction, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: const Text(
            'Are you sure?',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text(
                'YES',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Add your OK button action here
                customFunction();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlert(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                child: const Text(
                  'Got it',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ]),
          ],
        );
      },
    );
  }

  Future<void> goToPage(BuildContext context, Widget page) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  void showLoading(BuildContext context) {
    //Show loading animation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
