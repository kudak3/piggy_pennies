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
  String choreName, price;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Price and Duration'),
      ),
      body: Container(
        
        margin: const EdgeInsets.only(
            top: 50, left: 16.0, right: 16.0, bottom: 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Add a Price Value',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 5.0),
                Text('How much do you want to pay',style: TextStyle(fontSize: 12),),
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
                        icon: Icon(Icons.attach_money, color: Color.fromRGBO(38, 131, 138,1)),
                        labelText: "Price",
                        hintText: "Enter Amount"),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Pick a Due date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 5.0),
                Text(
                  'When do you want it finished',
                  style: TextStyle(fontSize: 12),
                ),
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
                        icon: Icon(Icons.calendar_today, color: Color.fromRGBO(38, 131, 138,1)),
                        labelText: "Due date",
                        hintText: "Date Of Birth"),
                  ),
                ),
                SizedBox(height:30.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color.fromRGBO(38, 131, 138,1),
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
        builder: (_) => AddChore(
            choreName: widget.chorename, price: price, dueDate: selectedDate),
      ),
    );
  }
}
