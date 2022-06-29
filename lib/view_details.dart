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
  final docId;

  ViewDetails(
      {this.firstName, this.lastName, this.checkValue, this.uid, this.docId});
  @override
  Widget build(BuildContext context) {
    // Future updateData() async {
    //   DocumentReference users = await FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(uid)
    //       .collection('form')
    //       .doc();

    //   return ;
    // }

    late TextEditingController updateFirstName = TextEditingController();
    late TextEditingController updateLastName = TextEditingController();
    late TextEditingController updateUserName = TextEditingController();

    void showDia() {
      showDialog(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: AlertDialog(
            title: Text('Update Data'),
            content: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: updateFirstName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: updateLastName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: updateUserName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      labelText: 'Username',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                   CollectionReference user = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('form');

      user.doc(docId).update(
        {
          "firsname": updateFirstName.text,
          "lastname": updateLastName.text,
          "username": updateUserName.text
        },
      ).then(
        (value) => Navigator.of(context).pop(),
      );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
        ),
      );
      // print(updateFirstName.text);
      // print(updateUserName.text);
      // print(updateLastName.text);
     
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
              showDia();

              // showDialog(
              //   context: context,
              //   builder: (_) => SingleChildScrollView(
              //     child: AlertDialog(
              //       title: Text('Update Data'),
              //       content: Column(
              //         children: [
              //           Container(
              //             margin: EdgeInsets.only(bottom: 20),
              //             child: TextField(
              //               controller: updateFirstName,
              //               decoration: InputDecoration(
              //                 border: OutlineInputBorder(),
              //                 hintText: 'First Name',
              //                 labelText: 'First Name',
              //               ),
              //             ),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(bottom: 20),
              //             child: TextField(
              //               controller: updateLastName,
              //               decoration: InputDecoration(
              //                 border: OutlineInputBorder(),
              //                 hintText: 'Last Name',
              //                 labelText: 'Last Name',
              //               ),
              //             ),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(bottom: 20),
              //             child: TextField(
              //               controller: updateUserName,
              //               decoration: InputDecoration(
              //                 border: OutlineInputBorder(),
              //                 hintText: 'Username',
              //                 labelText: 'Username',
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       actions: [
              //         TextButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //           child: Container(
              //             padding: const EdgeInsets.all(14),
              //             child: const Text("okay"),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // );

              // CollectionReference user = FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(uid)
              //     .collection('form');

              // user.doc(docId).update(
              //   {
              //     "firsname": updateFirstName.text,
              //     "lastname": updateLastName.text,
              //     "username": updateUserName.text
              //   },
              // ).then(
              //   (value) => print('Data Updated'),
              // );
            },
            child: Text('Update data'),
          )
        ],
      ),
    );
  }
}
