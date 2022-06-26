// ignore_for_file: prefer_const_constructors

import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:recipe_app/test_page.dart';

class TestStore extends StatefulWidget {
  TestStore({Key? key}) : super(key: key);

  @override
  State<TestStore> createState() => _TestStoreState();
}

class _TestStoreState extends State<TestStore> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  Future<void>? _addUser() async {
    try {
      // final FirebaseAuth _auth = FirebaseAuth.instance;
      var email = emailController.text;
      var password = passwordController.text;
      // Map<String, dynamic> user = {"email": email, "password": password};
      // final userCredential = FirebaseAuth.instance;
      //     final userC = userCredential.createUserWithEmailAndPassword(email: email, password: password);
      // print(userC);

      // try {
      //   final credential =
      //       _auth.signInWithEmailAndPassword(email: email, password: password);
      //   print('This is the data of ${credential}');
      //   if (credential != 'null') {
      //     print('Logged IN');
      //     Navigator.push(
      //         context, CupertinoPageRoute(builder: (ctx) => TestFormPage()));
      //   } else {
      //     // print("Error");
      //   }
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     print('user not found');
      //   }
      // }

      // try {
      //   final userCredential = await FirebaseAuth.instance
      //       .signInWithEmailAndPassword(email: email, password: password);
      //   print(userCredential);
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     print('user not found');
      //   } else {
      //     print('nothing happend exept error');
      //   }
      // }

      return user
          .add({
            "email": email,
            "password": password,
          })
          .then(
            (value) => print('User added'),
          )
          .catchError(() => print('has error'));

      // setState(() {
      //   email = '';
      //   password = '';
      // });
    } catch (e) {
      print(e);
    }
  }

  Future<void>? _verifyNum() async {
    var phone = phoneController.text;

    final _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phone) {},
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String? verificationId, int? resendToken) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Enter the code'),
                content: Column(
                  children: [
                    TextField(
                      controller: pinController,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var code = pinController.text;
                        PhoneAuthCredential phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId!, smsCode: code);
                        final result = await _auth
                            .signInWithCredential(phoneAuthCredential);
                        if (result != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => TestFormPage(),
                            ),
                          );
                        }
                      },
                      child: Text('Verify Code'),
                    ),
                  ],
                ),
              );
            });
      },
      codeAutoRetrievalTimeout: (String? verificationId) {},
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login/Sign Up'),
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
                child: Text('Create User'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Phone Number',
                  labelText: 'Phone Number',
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
                  _verifyNum();
                },
                child: Text('Send Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
