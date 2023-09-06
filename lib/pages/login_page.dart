// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/components/continue_with_google.dart';
import 'package:new_ess/components/my_button.dart';
import 'package:new_ess/pages/forgot_password_page.dart';
import '../components/my_textfield.dart';
import '../components/register_now_member.dart';
import '../utilities/utility.dart';

class LoginPage extends StatefulWidget {
  //onTap Function for the clickable "Register now" Text
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //Snack instance
    var utility = Utility();

    //Text fields controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    //Button method
    void signIn() async {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          utility.showSnackBar(context, "Login Failed. User not found.");
        } else if (e.code == 'invalid-email') {
          utility.showSnackBar(context, "Login Failed. Invalid email.");
        } else {
          utility.showSnackBar(
              context, "Login Failed. Check your credentials.");
        }
      }

      Navigator.pop(context);
    }

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

                //welcome message
                const SizedBox(height: 20),
                const Text("Welcome, please Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),

                // email text field
                const SizedBox(height: 30),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                ),

                // password text field
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                //forgot password?
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        ),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Sign in button
                const SizedBox(height: 20),
                MyButton(
                  onTap: signIn,
                  txt: "Sign In",
                ),

                //or continue with
                const SizedBox(height: 40),
                const ContinueGoogle(),

                // not a member? register now
                const SizedBox(height: 80),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const RegisterNow(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
