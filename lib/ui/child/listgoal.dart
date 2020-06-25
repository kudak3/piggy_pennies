import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:piggy_pennies/model/goal.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/authentication/child_reg.dart';


class ListGoals extends StatefulWidget {
  final String fullName;
  ListGoals({this.fullName});

  _ListGoalsState createState() => _ListGoalsState();
}

class _ListGoalsState extends State<ListGoals> {
  Stream<List<Goal>> goallist;
  List<Goal> goals = [];

  bool _isLoading = false;



  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  String email, password, confirmPassword, username;

  @override
  initState() {
    getGoals();

    super.initState();
  }

  getGoals() async {
    var tmp = await firestoreService.getChildren();

    setState(() {
      goals = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fullName + "Goals"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
            top: 50, left: 16.0, right: 16.0, bottom: 10.0),
        child: _isLoading
            ? Center(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(height: 300, child: listView(goals)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color.fromRGBO(38, 131, 138, 1),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChildReg(
                                newacc: false,
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                        child: Text('Add New Goal'),
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

  listView(List<Goal> goals) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: goals.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2.0,
            child: Row(
              children: <Widget>[
                Column(

                  children: <Widget>[
                    Text("Bear toy"),
                    Divider(),
                  
                  ],
                ),
                Image.asset('assets/toys images/sofa_1.png')
              ],
            ),
          );
        },
      );

 
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.green,
        fontSize: 16.0);
  }
}
