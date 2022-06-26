import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data.dart';
import 'package:recipe_app/view_details.dart';

class ViewData extends StatefulWidget {
  late String? uid;
  ViewData({this.uid});
  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List data = [];
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
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (_, i) {
                final data = docs[i].data();
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ViewDetails(firstName: data['firsname'],lastName: data['lastname'],checkValue: data['myCheckValue1'],)));
                    },
                    child: Container(
                      child: Text(
                        'Full Name ${data['firsname']} ${data['lastname']}',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
              itemCount: docs.length,
            );
          }
          return Container(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}