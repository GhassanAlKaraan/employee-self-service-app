import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/home/home_page.dart';
import 'package:new_ess/login_register/pages/login_page.dart';

import '../components/my_button.dart';
import '../components/my_button_2.dart';
import '../login_register utilities/utility.dart';

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
        Duration(seconds: 3),
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
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();


      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 10));
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

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify your email"),
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
                    const Icon(Icons.verified_user, size: 80),

                    //Message
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Check your inbox to verify your account.",
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

                    // TODO: Disable the button for a few seconds before the user can resend email.
                    // The button wont work for 10 seconds, but we need to change the color maybe
                    MyButton(onTap: canResendEmail? resendEmail : (){utility.showSnackBar(context, "Wait before resending email");}, txt: "Re-send Email"),

                    const SizedBox(height: 20),
                    MyButton2(onTap: ()=> cancel(), txt: "Cancel"),
                  ],
                ),
              ),
            ),
          ),
        );

  void resendEmail() async {
    utility.showLoading(context);

    try {
      // Start
      sendVerificationEmail();
      // End

      utility.showSnackBar(context, "TODO --- Email re-sent");
    }catch (e) {
      utility.showSnackBar(context, e.toString());
    }
    Navigator.pop(context);
  }

  void cancel() {
    utility.showAlertDialog(context, firebaseLogout, "Cancel");
  }

  //SIGN OUT method
  void firebaseLogout() {
    FirebaseAuth.instance.signOut();
  }
}
