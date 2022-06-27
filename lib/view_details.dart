import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  final firstName;
  final lastName;
  final checkValue;

  ViewDetails({this.firstName, this.lastName, this.checkValue});
  @override
  Widget build(BuildContext context) {
    var arr = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          
         for (var item in checkValue) Column(children: [
          Text(item),
         ],),
          Text(firstName),
          Text(lastName),
        ],
      ),
    );
  }
}
