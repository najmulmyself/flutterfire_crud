// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TestStore extends StatefulWidget {
  TestStore({Key? key}) : super(key: key);

  @override
  State<TestStore> createState() => _TestStoreState();
}

class _TestStoreState extends State<TestStore> {
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
                onPressed: () {},
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
