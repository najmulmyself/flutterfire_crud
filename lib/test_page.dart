// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radio_button_form_field/radio_button_form_field.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:recipe_app/api/database.dart';

class TestFormPage extends StatefulWidget {
  TestFormPage({Key? key}) : super(key: key);

  @override
  State<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends State<TestFormPage> {
  final formKey = GlobalKey<FormState>();
  Database? db;
  List docs = [];
  void initalise() {
    db = Database();
    db!.initialise();
    db!.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  TextEditingController myUserName = TextEditingController();
  TextEditingController myFirstName = TextEditingController();
  TextEditingController myLastName = TextEditingController();
  TextEditingController myPass = TextEditingController();
  TextEditingController myConfirmPass = TextEditingController();

  bool? checkboxIconFormFieldValue = false;
  String myRadioValue = 'Dummy Value';
  String myCheckValue = '';
  String myDropDownValue = '';
  List<Map> gadget = [
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
  List<Map> language = [
    {
      'value': 'Dart',
      'name': 'Dart',
    },
    {
      'value': 'Python',
      'name': 'Python',
    },
    {
      'value': 'Javascript',
      'name': 'Javascript',
    },
  ];
  bool _ageHasError = false;
  bool _genderHasError = false;
  var genderOptions = ['Male', 'Female', 'Other'];

  String? select;

  void onChanged(dynamic val) => print(val.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
              Text('Select A gadget'),
              RadioButtonFormField(
                toggleable: true,
                data: gadget,
                value: 'value',
                display: 'name',
                context: context,
                validator: (value) {
                  if (value.toString() == 'null') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Select a value'),
                      ),
                    );
                    return null;
                  } else {
                    setState(() {
                      myRadioValue = value;
                      print(myRadioValue);
                    });
                  }
                  return null;
                },
              ),
              Text('Select A Language'),
              RadioButtonFormField(
                toggleable: true,
                data: language,
                value: 'value',
                display: 'name',
                context: context,
                validator: (value) {
                  if (value.toString() == 'null') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Select a value'),
                      ),
                    );
                    return null;
                  } else {
                    setState(() {
                      myRadioValue = value;
                      print(myRadioValue);
                    });
                  }
                  return null;
                },
              ),
              // CheckboxListTileFormField(
              //   title: Text('Laptop!'),
              //   onSaved: (bool? value) {
              //     print('This is : $value');
              //   },
              //   validator: (bool? value) {
              //     if (value!) {
              //       return null;
              //     } else {
              //       return 'False!';
              //     }
              //   },
              //   onChanged: (value) {
              //     if (value) {
              //       print("ListTile Checked :)");
              //     } else {
              //       print("ListTile Not Checked :(");
              //     }
              //   },
              // ),
              // CheckboxListTileFormField(
              //   title: Text('Desktop!'),
              // ),
              // CheckboxListTileFormField(
              //   title: Text('Phone!'),
              // ),
              // CheckboxIconFormField(
              //   context: context,
              //   initialValue: checkboxIconFormFieldValue!,
              //   enabled: true,
              //   iconSize: 32,

              //   // onSaved: (bool? value) {
              //   //   checkboxIconFormFieldValue = value;
              //   // },
              //   // onChanged: (value) {
              //   //   if (value) {
              //   //     print("Icon Checked :)");
              //   //   } else {
              //   //     print("Icon Not Checked :(");
              //   //   }
              //   // },
              // ),

              // MultiSelectFormField(
              //   // autovalidate: AutovalidateMode.disabled,
              //   dataSource: gadget,
              //   textField: 'display',
              //   valueField: 'value',
              //   hintWidget: Text('Please choose one or more'),
              //   // initialValue: myCheckValue,
              // ),
              Text('Select A gadget'),
              FormBuilderCheckboxGroup(
                name: 'Gadget',
                orientation: OptionsOrientation.vertical,
                options: const [
                  FormBuilderFieldOption(value: 'Phone'),
                  FormBuilderFieldOption(value: 'Desktop'),
                  FormBuilderFieldOption(value: 'Laptop'),
                  FormBuilderFieldOption(value: 'Tablet'),
                ],
                wrapDirection: Axis.horizontal,
                // wrapVerticalDirection: VerticalDirection.down,
                onSaved: onChanged,
                validator: (value) {
                  if (value.toString() == 'null') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Select a value'),
                      ),
                    );
                    return null;
                  } else {
                    myCheckValue = value.toString();
                    print(myCheckValue);
                  }
                },
              ),
              Text('Select A Language'),

              FormBuilderCheckboxGroup(
                name: 'Language',
                orientation: OptionsOrientation.vertical,
                options: const [
                  FormBuilderFieldOption(value: 'C'),
                  FormBuilderFieldOption(value: 'Go'),
                  FormBuilderFieldOption(value: 'Python'),
                  FormBuilderFieldOption(value: 'Java'),
                ],
                wrapDirection: Axis.horizontal,
                // wrapVerticalDirection: VerticalDirection.down,
                onSaved: onChanged,
                validator: (value) {
                  if (value.toString() == 'null') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Select a value'),
                      ),
                    );
                    return null;
                  } else {
                    myCheckValue = value.toString();
                    print(myCheckValue);
                  }
                  return null;
                },
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     if (formKey.currentState!.validate()) {}
              //     // print(myCheckValue);
              //   },
              //   child: Text('Submit'),
              // ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: myUserName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          hintText: 'Enter Your Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: myFirstName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          hintText: 'Enter Your First Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: myLastName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                          hintText: 'Enter Your Last Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: myPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: myConfirmPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          hintText: 'Enter Confirm Password',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                        // print(myCheckValue);
                        print(myUserName.text);
                        print(myFirstName.text);
                        print(myLastName.text);
                        print(myPass.text);
                        print(myConfirmPass.text);
                      },
                      child: Text('Submit'),
                    ),
                  ],
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
                    print(myDropDownValue);
                  }
                },
                onChanged: (val) {
                  setState(() {
                    print(val);
                  });
                },
                valueTransformer: (val) => val?.toString(),
              ),
              // Text(docs.name.to), 
            ],
          ),
        ),
      ),
    );
  }
}
