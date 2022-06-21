// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TestStore extends StatefulWidget {
  TestStore({Key? key}) : super(key: key);

  @override
  State<TestStore> createState() => _TestStoreState();
}

class _TestStoreState extends State<TestStore> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void>? _addUser() {
    try {
      var email = emailController.text;
      var password = passwordController.text;
      // Map<String, dynamic> user = {"email": email, "password": password};

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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          ],
        ),
      ),
    );
  }
}
