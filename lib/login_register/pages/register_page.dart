import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/continue_with_google.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/signin_now_member.dart';
import '../utils/auth_utils.dart';

class RegisterPage extends StatefulWidget {
  //onTap Function for the clickable "Login now" Text
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Snack instance
  var utility = Utility();

  //Text fields controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //dispose text fields
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  //TODO: ABUSE CONTROL - register user cool down
  //Register User
  Future signUp() async {
    if (!isInfoNotEmpty() && !passwordsMatch()) {
      return; // Input Validation
    }
    //TODO: start loading animation
    //utility.showLoading(context);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //TODO: stop loading animation
      //Navigator.of(context).pop();

      await addUserDetails(nameController.text.trim(), emailController.text.trim(), false);



    } on FirebaseAuthException catch (e) {
      utility.showSnackBar(context, e.toString());
    }

  }

  Future<void> addUserDetails(String name, String email, bool verified) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'verified email': verified,
      });
    } catch (e) {
      utility.showSnackBar(context, e.toString());
    }
  }

  bool isInfoNotEmpty() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      utility.showSnackBar(context, "Fields can not be empty!");
      return false;
    } else {
      return true;
    }
  }

  bool passwordsMatch() {
    if (passwordController.text == confirmPasswordController.text) {
      return true;
    } else {
      utility.showSnackBar(context, "Passwords do not match!");
      return false;
    }
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

                //welcome message
                const SizedBox(height: 20),
                const Text("Let's make an account for you!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),

                // Username text field
                const SizedBox(height: 30),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),

                // email text field
                const SizedBox(height: 10),
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

                // confirm password text field
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                // Sign in button
                const SizedBox(height: 20),
                MyButton(
                  onTap: signUp,
                  txt: "Sign Up",
                ),

                //or continue with
                const SizedBox(height: 20),
                const ContinueGoogle(),

                // not a member? register now
                const SizedBox(height: 20),
                GestureDetector(onTap: widget.onTap, child: const LoginNow()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
