// ignore_for_file: prefer_typing_uninitialized_variables

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data.dart';

class ViewDetails extends StatelessWidget {
  final firstName;
  final lastName;
  final checkValue;
  final uid;

  ViewDetails({this.firstName, this.lastName, this.checkValue, this.uid});
  @override
  Widget build(BuildContext context) {
    Future updateData() async {
      DocumentReference users = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('form')
          .doc();

      return ;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Text("First Name : $firstName"),
          Text("Last Name : $lastName"),
          Card(
            child: Column(
              children: [
                Text("Checked Item"),
                for (var item in checkValue)
                  Column(
                    children: [
                      Text(item),
                    ],
                  ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                updateData();
              },
              child: Text('Update data'))
        ],
      ),
    );
  }
}
