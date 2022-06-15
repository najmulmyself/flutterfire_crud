import 'package:flutter/material.dart';
import 'package:radio_button_form_field/radio_button_form_field.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class TestFormPage extends StatefulWidget {
  TestFormPage({Key? key}) : super(key: key);

  @override
  State<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends State<TestFormPage> {
  final formKey = GlobalKey<FormState>();
  bool? checkboxIconFormFieldValue = false;
  String myValue = 'Dummy Value';
  List<Map> person = [
    {
      'value': 'Phone',
      'name': 'Phone',
    },
    {
      'value': 'Desktop',
      'name': 'Desktop',
    },
    {
      'value': 'Laptop',
      'name': 'Laptop',
    },
  ];
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
            // Radio(
            //     value: person.length,
            //     groupValue: select,
            //     onChanged: (value) {
            //       setState(() {
            //         select = value.toString();
            //       });
            //     })

            RadioButtonFormField(
              toggleable: true,
              data: person,
              value: 'value',
              display: 'name',
              context: context,
              validator: (value) {
                if (value.toString() == 'null') {
                  return null;
                } else {
                  setState(() {
                    myValue = value;
                    print('I am from set state 62 : $myValue');
                  });
                }
                return null;
              },
              // onSaved: (value) {
              //   setState(() {
              //     myValue = value;
              //     myValue = value.toString();
              //     print(myValue);
              //   });
              // },
            ),
            CheckboxListTileFormField(
              title: Text('Laptop!'),
              onSaved: (bool? value) {
                print('This is : $value');
              },
              validator: (bool? value) {
                if (value!) {
                  return null;
                } else {
                  return 'False!';
                }
              },
              onChanged: (value) {
                if (value) {
                  print("ListTile Checked :)");
                } else {
                  print("ListTile Not Checked :(");
                }
              },
            ),
            CheckboxListTileFormField(
              title: Text('Desktop!'),
            ),
            CheckboxListTileFormField(
              title: Text('Phone!'),
            ),
            CheckboxIconFormField(
              context: context,
              initialValue: checkboxIconFormFieldValue!,
              enabled: true,
              iconSize: 32,
              onSaved: (bool? value) {
                checkboxIconFormFieldValue = value;
              },
              onChanged: (value) {
                if (value) {
                  print("Icon Checked :)");
                } else {
                  print("Icon Not Checked :(");
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // print(myValue);
                }
                print('I am from onPressed 122: $myValue');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
