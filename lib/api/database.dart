import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/api/services.dart';

class Database {
  FirebaseFirestore? firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List<dynamic>> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore!.collection('formData').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc["name"],
            "code": doc["code"],
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    throw Text('Error');
  }
}

