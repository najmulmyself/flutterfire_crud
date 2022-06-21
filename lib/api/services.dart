import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  // final FirebaseAuth _auth;

  // AuthService(this._auth);

  // Stream<User>   get AuthStateChanges => _auth.idTokenChanges();
  
  
final DocumentReference documentReference =
    FirebaseFirestore.instance.collection('users').doc('eachUser');
final FirebaseAuth _auth = FirebaseAuth.instance;

  }

  // var auth = FirebaseAuth();