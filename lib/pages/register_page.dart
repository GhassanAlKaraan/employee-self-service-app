import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/components/continue_with_google.dart';
import 'package:new_ess/components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/signin_now_member.dart';
import '../utilities/utility.dart';

class RegisterPage extends StatefulWidget {
  //onTap Function for the clickable "Login now" Text
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    //Snack instance
    var utility = Utility();

    //Text fields controllers
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();



    //Register User


    void signUp() async{
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try{

        if(passwordController.text == confirmPasswordController.text){
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        }else{
          utility.showSnackBar(context, "Passwords do not match!");
        }
      } on FirebaseAuthException catch(e){
        utility.showSnackBar(context, "Registration failed!");
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
                    height: 120),

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
                  controller: usernameController,
                  hintText: 'Username',
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
                MyButton(onTap: signUp, txt: "Sign Up",),

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