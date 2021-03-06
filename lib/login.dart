// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/test_page.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void>? _addUser() async {
    var email = emailController.text;
    var password = passwordController.text;

    final _auth = FirebaseAuth.instance;
    try {
      final UserCredential? userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential!.user!.uid);
      final uid = userCredential.user!.uid;
      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Logged in Successfully',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => TestFormPage(uid: uid,),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Incorrect password!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Incorrect email!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign In'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Email',
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Password',
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              width: double.infinity,
              color: Colors.blue,
              child: ElevatedButton(
                onPressed: () {
                  _addUser();
                },
                child: Text('Sign In'),
              ),
            ),
            Text('New User?'),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => SignIn()));
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
