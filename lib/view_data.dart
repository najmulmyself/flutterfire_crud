import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data.dart';
import 'package:recipe_app/test_page.dart';
import 'package:recipe_app/view_details.dart';

class ViewData extends StatefulWidget {
  late String? uid;
  ViewData({this.uid});
  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List data = [];
  String docId = "";
  var errormsg = Text('No data Found');
  // late String? uid = widget.uid;

  // final user;
  // _ViewDataState({this.user});

  // Future viewData() async {
  //   CollectionReference user = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('form');

  //   return FutureBuilder(
  //     future: user.doc().get(),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final data = snapshot.data!.data() as Map<String, dynamic>;
  //         return Text(
  //             "First name ${data['firstName']}  and ${data['lastName']}");
  //       }
  //       return Text('loading ...');
  //     },
  //   );
  // }

  // CollectionReference user = FirebaseFirestore.instance.collection('users').doc(uid).collection('form');

  @override
  Widget build(BuildContext context) {
    final uid = widget.uid;
    print(" from view data : $uid");

    CollectionReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('form');

    // var querySnapshot = user.get();
    // for (var queryDocumentSnapshot in querySnapshot.docs) {}

    return SafeArea(
        child: Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('form')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.size == 0) {
            // need to declare it first to show [no data found]
            return Center(child: Text('No Data found'));
          } else if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            // print(docs[0].id);
            return ListView.builder(
              itemBuilder: (_, i) {
                // snapshot.data.docs.forEach(
                //   (element) {
                //     docId = element.id;
                //   },
                // );
                final data = docs[i].data();
                return Center(
                  child: GestureDetector(
                    onTap: () {
                
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewDetails(
                                    docId: docs[i].id,
                                    firstName: data['firsname'],
                                    lastName: data['lastname'],
                                    checkValue1: data['myCheckValue1'],
                                    checkValue2: data['myCheckValue2'],
                                    dropDownValue: data['myDropdownValue'],
                                    radioValue: data['myRadioValue1'],
                                    uid: uid,
                                  )));
                    },
                    child:
                        //  Container(
                        //   child: Text(
                        //     'Full Name ${data['firsname']} ${data['lastname']}',
                        //     style: TextStyle(fontSize: 40),
                        //   ),
                        // ),
                        Card(
                      child: ListTile(
                        // leading: GestureDetector(
                        //   onTap: () {
                        //     CollectionReference usr =
                        //         FirebaseFirestore.instance.collection('users');
                        //     usr
                        //         .doc(widget.uid)
                        //         .collection('form')
                        //         .doc(docs[i].id)
                        //         .update(
                        //       {
                        //         "firsname": "Najmul",
                        //         "lastname": "Huda",
                        //         "username": "najmulmyself"
                        //       },
                        //     ).then(
                        //       (value) => print('Data Updated'),
                        //     );
                        //   },
                        //   child: Icon(Icons.edit),
                        // ),
                        title: Text('${data['firsname']} ${data['lastname']}'),
                        subtitle: Text('${data['username']}'),
                        trailing: GestureDetector(
                          onTap: () {
                            // print(docs[i].id);
                            print(docs);
                            if (docs == 0) {
                              Center(child: Text('No Data Found'));
                            } else if (i >= 0) {
                              user
                                  .doc(docs[i].id)
                                  .delete()
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Deleted Successfully',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        backgroundColor: Colors.yellow,
                                      ),
                                    ),
                                  )
                                  .catchError((error) {
                                return Text('Error');
                              });
                            }
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: docs.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
