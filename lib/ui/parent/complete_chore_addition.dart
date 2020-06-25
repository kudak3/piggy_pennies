import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/allowance.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/parent/choose_chore.dart';

import 'homepage.dart';

class AddChore extends StatefulWidget {
  final String choreName, price, dueDate;
  AddChore({this.choreName, this.price, this.dueDate});
  _AddChoreState createState() => _AddChoreState();
}

class _AddChoreState extends State<AddChore> {
  List frequencyList = ['once', 'everyday', 'weekly', 'monthly', 'Customize'];
  var selectedDate;
  DateTime date;
  DateTime birthDate;
  String choreName;
  String frequency;
  String notes;
  bool _isLoading = false;

  Allowance allowance;

  List<Child> children;
  List<Child> assignees = [];

  FirestoreService get firestoreService => GetIt.I<FirestoreService>();

  initState() {
    getChildren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Finish adding  Chore'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  top: 10, left: 16.0, right: 16.0, bottom: 10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text('Frequency',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 10.0),
                      Text('How often should this chore be done',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20.0),
                      GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: frequencyList
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    frequency = e;
                                  },
                                  child: Card(
                                      elevation: 2.0,
                                      child: Center(child: Text(e))),
                                ),
                              )
                              .toList()),
                      SizedBox(height: 10.0),
                      Text('Assignee',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 10.0),
                      Text('To whom are you assigning the task?',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: children.map((e) => Row(
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        createAllowance(Allowance(child: e,paid: false,choreName: widget.choreName,amount:widget.price));
                                        setState(() {
                                          assignees.contains(e)
                                              ? assignees.remove(e)
                                              : assignees.add(e);
                                        });
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                              height: 50.0,
                                              child: CircleAvatar(
                                                child: Text(
                                                  e.fullName.substring(0,3),
                                                ),
                                              )),
                                          assignees.contains(e)
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )
                                              : Container(height: 0, width: 0),
                                        ],
                                      )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              ),).toList()
                        
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Notes ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text('(Optional)'),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 8.0),
                        child: TextFormField(
                          // controller: _pass,
                          onSaved: (value) => setState(() {
                            notes = value;
                          }),
                          // validator: _validatePassword,
                          decoration: InputDecoration(
                              icon: Icon(Icons.edit,
                                  color: Color.fromRGBO(38, 131, 138, 1)),
                              labelText: "Notes",
                              hintText: "Enter Optional notes"),
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                              left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
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

  getChildren() async {
    var tmp = await firestoreService.getChildren();
    setState(() {
      children = tmp;
    });
    print('======children are hre====');
  }

  createAllowance(Allowance allowance) async{
    await firestoreService.createAllowance(allowance);
  }

  _next() async {
    setState(() {
      _isLoading = true;
    });

    APIResponse result = await firestoreService.registerChore(
      Chore(
        name: widget.choreName,
        frequency: frequency,
        dueDate: widget.dueDate,
        price: widget.price,
        notes: notes,
        assignees: assignees
      ),
    );

    setState(() {
      _isLoading = false;
    });

    if (!result.error) {
      await showToast("Chore successfully registered");

      await showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (_) => AlertDialog(
                title: Text('Chore Added Successfully'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Do you want to add another Chore?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChooseChore(),
                          ));
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
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
