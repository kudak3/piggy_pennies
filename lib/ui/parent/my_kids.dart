import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/authentication/child_reg.dart';
import 'package:piggy_pennies/ui/parent/homepage.dart';

class MyKids extends StatefulWidget {
  // MyKids({this.childlist});

  _MyKidsState createState() => _MyKidsState();
}

class _MyKidsState extends State<MyKids> {
  Stream<List<Child>> childlist;

  bool _isLoading = false;

  final TextEditingController _pass = TextEditingController();

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
        FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();
  String email, password, confirmPassword, username;

  @override
  initState(){

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Kids"),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
            top: 10, left: 16.0, right: 16.0, bottom: 10.0),
        child: _isLoading
            ? Center(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: firestoreService.getChildrenByParentId(),
                        stream: firestoreService.getChildrenByParentId(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Child> children = snapshot.data;
                          return listView(children);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChildReg(),
                            ),
                          );
                        },
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                        child: Text('Add a Child'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  listView(List<Child> children) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => null,
            leading: Icon(Icons.person),
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                SizedBox(height: 5.0),
                Text(children[index].fullName),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    SizedBox(height: 5.0),
                    Text(children[index].birthDate),
                  ],
                ),
                Text(children[index].gender),
              ],
            ),
          );
        },
      );

  String _validateUsername(String value) {
    if (value.length < 4)
      return 'Please enter a username with more than 5 characters';
    else
      return null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8)
      return 'Passwords must have a minimum of 8 characters';
    else
      return null;
  }

  String _validateConfirmPassword(String value) {
    if (value != _pass.text)
      return 'Passwords do not match';
    else
      return null;
  }

  _signUp() async {
    setState(() {
      _isLoading = true;
    });

    APIResponse result =
        await authenticationService.signUpWithEmail(email, password, username);

    setState(() {
      _isLoading = false;
    });

    if (!result.error) {
      await showToast("User successfully registered");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      );
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
