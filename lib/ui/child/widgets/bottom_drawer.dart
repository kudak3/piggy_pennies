import 'package:flutter/material.dart';

class BottomDrawer extends StatefulWidget {
  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.yellow),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.map, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.location_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
