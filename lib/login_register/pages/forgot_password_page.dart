import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../utils/auth_utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //Utility
  final utility = Utility();
  bool canResendEmail = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    utility.showLoading(context);
    setState(() => canResendEmail = false);
    await Future.delayed(const Duration(seconds: 30));
    setState(() => canResendEmail = true);
    try {
      if(canResendEmail){
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());

        utility.showSnackBar(context, "Reset email sent");
      }else{
        utility.showSnackBar(context, "You need to wait before resending");
      }

      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      utility.showSnackBar(context, e.message.toString());
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
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
                const Icon(Icons.email_outlined, size: 80),

                //Message
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Receive an email to Reset your Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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

                MyButton(onTap: resetPassword, txt: canResendEmail? "Send Request" : "Sent!"),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
