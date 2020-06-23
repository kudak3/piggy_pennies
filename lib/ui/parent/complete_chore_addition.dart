import 'package:flutter/material.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/chore.dart';

class AddChore extends StatefulWidget {
  final String choreName,price,dueDate;
  AddChore({this.choreName,this.price,this.dueDate});
  _AddChoreState createState() => _AddChoreState();
}

class _AddChoreState extends State<AddChore> {
  List frequencyList = ['once', 'everyday', 'weekly', 'monthly', 'Customize'];
  var selectedDate;
  DateTime date;
  DateTime birthDate;
  String choreName;
  String frequency;

  List<Child> children;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Price and Duration'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Frequency'),
              SizedBox(height: 5.0),
              Text('How often should this chore be done'),
              SizedBox(height: 10.0),
              GridView.count(crossAxisCount: 2, children: <Widget>[
                ...frequencyList.map(
                  (e) => InkWell(
                    onTap: () {
                      frequency = e.name;
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Text(e.name),
                    ),
                  ),
                )
              ]),
              SizedBox(height: 10.0),
              Text('Assign'),
              SizedBox(height: 5.0),
              Text('To whom are you assigning the task?'),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  ...children.map(
                    (e) => Row(
                      children: <Widget>[
                        CircleAvatar(),
                        SizedBox(width: 10.0),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Text('Notes'),
                            Text('Optional'),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 8.0),
                child: TextFormField(
                  // controller: _pass,
                  onSaved: (value) => setState(() {
                    // password = value;
                  }),
                  // validator: _validatePassword,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.green),
                      labelText: "Price",
                      hintText: "Enter Amount"),
                ),
              ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
