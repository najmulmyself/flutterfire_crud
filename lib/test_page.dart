import 'package:flutter/material.dart';
import 'package:radio_button_form_field/radio_button_form_field.dart';

class TestFormPage extends StatefulWidget {
  TestFormPage({Key? key}) : super(key: key);

  @override
  State<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends State<TestFormPage> {
  final formKey = GlobalKey<FormState>();
  List person = ['Rahim', 'Karim', 'Hasem', 'Kashem'];
  String? select;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Radio(
                value: person.length,
                groupValue: select,
                onChanged: (value) {
                  setState(() {
                    select = value.toString();
                  });
                })
          ],
        ),
      ),
    );
  }
}
