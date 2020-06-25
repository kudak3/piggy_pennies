import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';


import 'package:piggy_pennies/ui/parent/homepage.dart';

import 'child/childhome.dart';


class LandingPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LandingPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isLoading = false;



    List<Child> children =[];
  FirestoreService get firestoreService => GetIt.I<FirestoreService>();

@override
initState(){
  getChildren();
  super.initState();
}

  getChildren() async {
    var tmp = await firestoreService.getChildren();

    setState(() {
      children = tmp;
     
    });
  }

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  String email, password, confirmPassword, username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
            top: 10, left: 16.0, right: 16.0, bottom: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/applogo.png'),
                          _isLoading
                  ? Center(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator()),
                    )
                  : Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5.0,
                            child: Column(
                              children: <Widget>[
                               
                                const SizedBox(height: 10.0),
                                 Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color.fromRGBO(38, 131, 138,1),
                              textColor: Colors.white,
                              onPressed: () {
                             
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomePage(),
                                  ),
                                );
                              },
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 16.0,
                                  bottom: 16.0),
                              child: Text('Continue as Parent'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          
                          Container(
                            
                            height: 100,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            width: double.infinity,
                            child: 
                            
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children
                              .map((e) => Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                        
                                           Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChildHome(child: e,),
                                  ),
                                );
                                        },
                                        child: CircleAvatar(
                                          foregroundColor: Colors.white,
                                          backgroundColor:  Color.fromRGBO(38, 131, 138,1),
                                          radius: 30.0,
                                          child:
                                              Text(e.fullName.substring(0, 2)),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ))
                              .toList()),
                            
                            
                          
                          ),
                       
                              ],
                            ),
                          ),
                         
                         
                       
                         
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
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
