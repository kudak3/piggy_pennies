
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';



class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Image.asset('assets/images/createzimlogo.png'),
              _isLoading
                  ? Center(
                      child: Padding(padding: EdgeInsets.all(10.0),child:CircularProgressIndicator()),
                    )
                  : Stack(
                      children: <Widget>[
                        Container(
                          // margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(
                              top: 0, left: 16.0, right: 16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: Colors.white),
                          child: SingleChildScrollView(
                            child: Form(
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
                                              username = value;
                                            }),
                                            validator: _validateUsername,
                                            decoration: InputDecoration(
                                                icon: Icon(Icons.person,
                                                    color: Colors.green),
                                                labelText: "Username",
                                                hintText:
                                                    "Please Enter Your prefered username"),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
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
                                                    color: Colors.green),
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
                                                    color: Colors.green),
                                                labelText: "Password",
                                                hintText: "Enter A password"),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 0.0, 20.0, 8.0),
                                          child: TextFormField(
                                            validator: _validateConfirmPassword,
                                            onSaved: (value) => setState(() {
                                              confirmPassword = value;
                                            }),
                                            decoration: InputDecoration(
                                                icon: Icon(Icons.lock,
                                                    color: Colors.green),
                                                labelText: "Confirm Password",
                                                hintText:
                                                    "Confirm your  password"),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          _signUp();
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
                                      child: Text('Join the Community'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color: Colors.grey.shade600,
                                      )),
                                      const SizedBox(width: 10.0),
                                      Text(
                                        "Or sign up with",
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                          child: Divider(
                                        color: Colors.grey.shade600,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      OutlineButton.icon(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        color: Colors.indigo[900],
                                        textColor: Colors.blue,
                                        onPressed: () => null 
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (_) => HomePage(),
                                        //   ),
                                        // ),
                                        ,
                                        icon: Icon(FontAwesomeIcons.facebook),
                                        label: Text('Facebook'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                      OutlineButton.icon(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                            color: Colors.black,
                                        textColor: Colors.black,
                                        onPressed: () => signupWithGoogle(),
                                        icon: Icon(FontAwesomeIcons.google),
                                        label: Text('Google'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ],
                                  ),
                              
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

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

  signupWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    APIResponse result = await authenticationService.signUpWithGoogle();

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
}
