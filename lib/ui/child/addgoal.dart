import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/api_response.dart';

import 'package:piggy_pennies/model/goal.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';

import 'listgoal.dart';

class AddGoal extends StatefulWidget {
  final String fullName;
  final String title;
  AddGoal({this.title,this.fullName});

  _AddGoalState createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  var selectedDate;
  DateTime date;
  DateTime birthDate;

  String childName;
  String goalName;
  String cost;
  String store;

   bool _isLoading = false;


  FirestoreService get firestoreService => GetIt.I<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin:
            const EdgeInsets.only(top: 50, left: 16.0, right: 16.0, bottom: 0),
        child: SingleChildScrollView(
          child: _isLoading ? Center :Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Icon(Icons.perm_media),
                      ),
                    ),
                    Text('Click to change the photo'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 8.0),
                  child: TextFormField(
                    // controller: _pass,
                    onSaved: (value) => setState(() {
                      goalName = value;
                    }),
                    // validator: _validatePassword,

                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money,
                            color: Color.fromRGBO(38, 131, 138, 1)),
                        labelText: "Goal Name",
                        hintText: "Enter the Name of the goal"),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 8.0),
                  child: TextFormField(
                    // controller: _pass,
                    onSaved: (value) => setState(() {
                      cost = value;
                    }),
                    // validator: _validatePassword,

                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money,
                            color: Color.fromRGBO(38, 131, 138, 1)),
                        labelText: "What is the cost",
                        hintText: "Cost of the item you want to buy"),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 8.0),
                  child: TextFormField(
                    // controller: _pass,
                    onSaved: (value) => setState(() {
                      store = value;
                    }),
                    // validator: _validatePassword,

                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money,
                            color: Color.fromRGBO(38, 131, 138, 1)),
                        labelText: "Where can you buy it?(Optional)",
                        hintText: "Enter the name of the shop"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color.fromRGBO(38, 131, 138, 1),
                    textColor: Colors.white,
                    onPressed: () {
                      _next();
                    },
                    padding: EdgeInsets.only(
                        left: 40.0, right: 30.0, top: 16.0, bottom: 16.0),
                    child: Text('Next'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _next() async {
    setState(() {
      _isLoading = true;
    });

    APIResponse result = await firestoreService.addGoal(Goal(
      goalName: goalName,
        childName:widget.fullName,cost:cost,store:store));

    setState(() {
      _isLoading = false;
    });

    if (!result.error) {
      await showToast("Goal added");

      await showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (_) => AlertDialog(
                title: Text('Success'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Do you want to add another Goal?'),
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
                          builder: (_) => ListGoals(),
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

