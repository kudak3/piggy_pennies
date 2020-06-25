import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';


import '../landingpage.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isLoading = false;

  final TextEditingController _pass = TextEditingController();

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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 20.0, 8.0),
                                  child: TextFormField(
                                    onSaved: (value) => setState(() {
                                      email = value;
                                    }),
                                    validator: _validateEmail,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person,
                                            color: Color.fromRGBO(38, 131, 138,1)),
                                        labelText: "Email",
                                        hintText:
                                            "Please Enter Your Email Address"),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 20.0, 8.0),
                                  child: TextFormField(
                                    controller: _pass,
                                    onSaved: (value) => setState(() {
                                      password = value;
                                    }),
                                    validator: _validatePassword,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock,
                                        
                                            color: Color.fromRGBO(38, 131, 138,1)),
                                        labelText: "Password",
                                        hintText: "Enter A password"),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color.fromRGBO(38, 131, 138,1),
                              textColor: Colors.white,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  _signIn();
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
                              child: Text('SignIn'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
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
                                    builder: (_) => SignupPage(),
                                  ),
                                );
                              },
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 16.0,
                                  bottom: 16.0),
                              child: Text('SignUp'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
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

  _signIn() async {
    setState(() {
      _isLoading = true;
    });

    APIResponse result =
        await authenticationService.signInWithEmail(email, password);

    setState(() {
      _isLoading = false;
    });

    if (!result.error) {
      await showToast("Login successful");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LandingPage(),
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
