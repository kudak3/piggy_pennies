import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/parent/choose_chore.dart';
import 'package:piggy_pennies/ui/parent/homepage.dart';

class ChildReg extends StatefulWidget {
  final bool newacc;
  final String parent;
  ChildReg({this.newacc, this.parent});
  _ChildRegState createState() => _ChildRegState();
}

class _ChildRegState extends State<ChildReg> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isLoading = false;
  var selectedDate;
  DateTime date;
  DateTime birthDate;
  final TextEditingController _pass = TextEditingController();

  FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  String gender, name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
            top: 10, left: 16.0, right: 16.0, bottom: 10.0),
        child: SingleChildScrollView(
          child: _isLoading
              ? Center(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator()),
                )
              : Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          widget.newacc ? 'Account Successfully created' : '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          widget.newacc
                              ? 'Add first Child'
                              : 'Add another child',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 2.0,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                children: <Widget>[
                                  RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        gender = 'Male';
                                      });
                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: Text('Boy'),
                                    padding: EdgeInsets.all(20.0),
                                    shape: CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {},
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 35.0,
                                    ),
                                    padding: EdgeInsets.all(30.0),
                                    shape: CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      gender = 'Female';
                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: Text('Girl'),
                                    padding: EdgeInsets.all(20.0),
                                    shape: CircleBorder(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Card(
                            elevation: 2.0,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0.0, 20.0, 8.0),
                                      child: TextFormField(
                                        onSaved: (value) => setState(() {
                                          name = value;
                                        }),
                                        validator: _validateUsername,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.person,
                                                color: Colors.green),
                                            labelText: "Name",
                                            hintText:
                                                "Enter the name of the Child"),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0.0, 20.0, 8.0),
                                      child: TextFormField(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        controller: TextEditingController(
                                            text: selectedDate == ""
                                                ? null
                                                : selectedDate),
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.calendar_today,
                                                color: Colors.blue),
                                            labelText: "D.O.B",
                                            hintText: "Date Of Birth"),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                              
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  registerChild();
                                } else {
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                }
                              },
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 16.0,
                                  bottom: 16.0),
                              child: Text('Next Step'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked.toString();
        birthDate = picked;
      });
  }

  String _validateUsername(String value) {
    if (value.length < 4)
      return 'Please enter a username with more than 5 characters';
    else
      return null;
  }

  registerChild() async {
    setState(() {
      _isLoading = true;
    });

    APIResponse result = await firestoreService.registerChild(Child(
        parentId: widget.parent, birthDate: selectedDate, gender: gender));

    setState(() {
      _isLoading = false;
    });

    if (!result.error) {
      await showToast("Child successfully registered");

      await showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (_) => AlertDialog(
                title: Text('Success'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Do you want to add another Child?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChooseChore(),
                        ),
                      );
                    },
                  ),
                ],
              ));
    } else {
      showToast(result.errorMessage);
    }
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.green,
        fontSize: 16.0);
  }
}
