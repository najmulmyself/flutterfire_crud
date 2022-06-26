import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  final firstName;
  final lastName;
  final checkValue;

  ViewDetails({this.firstName, this.lastName, this.checkValue});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: Column(
          children: [
            Container(
              height: 400,
              width: 300,
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return Text(checkValue[i]);
                },
                itemCount: checkValue.length,
              ),
            ),
            Text(firstName),
            Text(lastName),
          ],
        ));
  }
}
