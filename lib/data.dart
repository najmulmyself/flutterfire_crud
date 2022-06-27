import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  String? firstname;
  String? lastname;
  String? myCheckValue1;
  String? myCheckValue2;
  String? myDropdownValue;
  String? myRadioValue1;
  String? myRadioValue2;
  String? password;
  String? username;
  String? id;

  Data({
    this.firstname,
    this.lastname,
    this.myCheckValue1,
    this.myCheckValue2,
    this.myDropdownValue,
    this.myRadioValue1,
    this.myRadioValue2,
    this.password,
    this.username,
    this.id,
  });

  Data.fromDocument(DocumentSnapshot document ) {
    id = document.id;
    firstname = document['firstname'];
    lastname = document['lastname'];
    myCheckValue1 = document['myCheckValue1'];
    myCheckValue2 = document['myCheckValue2'];
    myDropdownValue = document['myDropdownValue'];
    myRadioValue1 = document['myRadioValue1'];
    myRadioValue2 = document['myRadioValue2'];
    password = document['password'];
    username = document['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['myCheckValue1'] = this.myCheckValue1;
    data['myCheckValue2'] = this.myCheckValue2;
    data['myDropdownValue'] = this.myDropdownValue;
    data['myRadioValue1'] = this.myRadioValue1;
    data['myRadioValue2'] = this.myRadioValue2;
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}
