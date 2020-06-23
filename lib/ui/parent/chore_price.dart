import 'package:flutter/material.dart';
import 'package:piggy_pennies/model/chore.dart';

import 'complete_chore_addition.dart';

class ChorePrice extends StatefulWidget {
  final String chorename;
  ChorePrice({this.chorename});
  _ChorePriceState createState() => _ChorePriceState();
}

class _ChorePriceState extends State<ChorePrice> {
 
  var selectedDate;
  DateTime date;
  DateTime birthDate;
  String choreName,price;

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
              Text('Add a Price Value'),
              SizedBox(height: 5.0),
              Text('How much do you want to pay'),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 8.0),
                child: TextFormField(
                  // controller: _pass,
                  onSaved: (value) => setState(() {
                    price = value;
                  }),
                  // validator: _validatePassword,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.green),
                      labelText: "Price",
                      hintText: "Enter Amount"),
                ),
              ),
              SizedBox(height: 10.0),
              Text('Pick a Due date'),
              SizedBox(height: 5.0),
              Text('When do you want it finished'),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextFormField(
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: TextEditingController(
                      text: selectedDate == "" ? null : selectedDate),
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today, color: Colors.blue),
                      labelText: "D.O.B",
                      hintText: "Date Of Birth"),
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              child: RaisedButton(
                color: Colors.green,
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
            ),],
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

   _next() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddChore(choreName:widget.chorename,price:price,dueDate:selectedDate),),
      );
  }
}
