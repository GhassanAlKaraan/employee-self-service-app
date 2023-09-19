import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/home/home_page.dart';
import '../components/my_button.dart';
import '../components/my_button_2.dart';
import '../utils/auth_utils.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final utility = Utility();
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //After use creation, check if email is verified
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    // Call after email validation
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      updateFirestore();
      timer?.cancel();
    }
  }

  Future updateFirestore() async {
    // Get current user email
    final String userEmail =
        FirebaseAuth.instance.currentUser!.email.toString();

    //Update the document
    FirebaseFirestore.instance.collection("users").doc(userEmail).update({
      "verified email": true,
    });
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 40));
      setState(() => canResendEmail = true);
    } catch (e) {
      utility.showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void resendEmail() async {
    utility.showLoading(context);

    if (canResendEmail) {
      try {
        sendVerificationEmail();
        utility.showSnackBar(context, "Verification resent, check your inbox");
      } catch (e) {
        utility.showSnackBar(context, e.toString());
      }
    } else {
      utility.showSnackBar(context, "You need to wait before resending");
    }


    Navigator.pop(context);
  }

  void cancel() {
    utility.showAlertDialog(context, firebaseLogout, "Cancel");
  }

  void firebaseLogout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify Your Email"),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Logo
                    const SizedBox(height: 20),
                    const Image(
                        image: AssetImage(
                          'assets/images/logos/gtsLogo.png',
                        ),
                        height: 100),

                    //Icon
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified,
                          size: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.mail, size: 80),
                      ],
                    ),

                    //Message
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "A verification email has been sent to your email address...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Button
                    const SizedBox(height: 50),
                    MyButton(
                        onTap: canResendEmail
                            ? resendEmail
                            : () {
                                utility.showSnackBar(
                                    context, "Wait before resending email");
                              },
                        txt: canResendEmail ? "Re-send Email" : "Sent!"),

                    const SizedBox(height: 20),
                    MyButton2(onTap: () => cancel(), txt: "Cancel"),
                  ],
                ),
              ),
            ),
          ),
        );
}
