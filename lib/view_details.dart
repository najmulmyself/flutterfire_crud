// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recipe_app/data.dart';

class ViewDetails extends StatefulWidget {
  final firstName;
  final lastName;
  final checkValue1;
  final checkValue2;
  final uid;
  final docId;
  final dropDownValue;
  final radioValue;

  ViewDetails({
    this.firstName,
    this.lastName,
    this.checkValue1,
    this.uid,
    this.docId,
    this.checkValue2,
    this.dropDownValue,
    this.radioValue,
  });

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  String myDropDownValue = '';
  var genderOptions = ['Male', 'Female', 'Other'];
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

    bool validate = false;

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
                      errorText: validate ? "value can't be null" : null,
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
                      errorText: validate ? "value can't be null" : null,
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
                      errorText: validate ? "value can't be null" : null,
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      labelText: 'Username',
                    ),
                  ),
                ),
                FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'gender',
                  decoration: InputDecoration(
                    labelText: 'Gender',
                  ),
                  hint: const Text('Select Gender'),
                  items: genderOptions
                      .map((gender) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  validator: (gender) {
                    if (gender.toString() == "null") {
                      print('dropdown value null');
                    } else {
                      myDropDownValue = gender.toString();
                      print('line no 119 : $myDropDownValue');
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      myDropDownValue = val!; // updated myDropDownValue // fixed update firebase
                    });
                    print('133 : $val');
                  },
                  valueTransformer: (val) => val?.toString(),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                onPressed: () {
                  if (updateFirstName.text.isEmpty &&
                      updateLastName.text.isEmpty &&
                      updateUserName.text.isEmpty) {
                    validate = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Field cant be Empty',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    validate = false;
                    CollectionReference user = FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .collection('form');

                    user.doc(widget.docId).update(
                      {
                        "firsname": updateFirstName.text,
                        "lastname": updateLastName.text,
                        "username": updateUserName.text,
                        "myDropdownValue": myDropDownValue,
                      },
                    ).then(
                      (value) => Navigator.of(context).pop(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Updated'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "First Name : ${widget.firstName}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Last Name :${widget.lastName}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "UserName : ",
            style: TextStyle(fontSize: 20),
          ),
          Text("Checked Item"),
          Card(
            child: Column(
              children: [
                for (var item in widget.checkValue1)
                  Column(
                    children: [
                      Text(item),
                    ],
                  ),
                for (var item in widget.checkValue2)
                  Column(
                    children: [
                      Text(item),
                    ],
                  ),
              ],
            ),
          ),
          Text('RadioValue'),
          Text(' ${widget.radioValue}'),
          Text('DropDown Value'),
          Text(' ${widget.dropDownValue}'),
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
