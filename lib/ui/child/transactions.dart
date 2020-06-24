import 'package:flutter/material.dart';
class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:Container(
          margin:
          const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {

            },
            padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 16.0,
                bottom: 16.0),
            child: Text('Add Goal '),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
