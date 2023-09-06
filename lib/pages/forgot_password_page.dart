import 'package:flutter/material.dart';
import 'package:new_ess/components/my_button.dart';
import 'package:new_ess/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_ess/utilities/utility.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //Utility
  final utility = Utility();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Icon(Icons.email_outlined, size: 80),

                //Message
                const SizedBox(height: 40),
                // TODO: make the text in 2 lines
                const Text(
                  "Receive an email to Reset your Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                //Text field
                const SizedBox(height: 20),
                MyTextField(
                    controller: emailController,
                    hintText: "Email address",
                    obscureText: false),

                // Button
                const SizedBox(height: 50),

                // TODO: Disable the button for a few seconds before the user can resend email.
                MyButton(onTap: resetPassword, txt: "Send Request"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      utility.showSnackBar(context, "Reset email sent");

      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      utility.showSnackBar(context, e.message.toString());
    }

    Navigator.pop(context);
  }
}
