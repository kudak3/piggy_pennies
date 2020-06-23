import 'package:flutter/material.dart';
import 'package:piggy_pennies/model/chore.dart';

class MyKidsDashBoard extends StatefulWidget {
  _MyKidsDashBoardState createState() => _MyKidsDashBoardState();
}

class _MyKidsDashBoardState extends State<MyKidsDashBoard> {
  String choreName;
  List<Chore> choresList = [
    Chore(
      id:'1',
      name: 'Goal',
      photoUrl: 'assets/icons/target.png',
    ),
    Chore(name: 'Chores',photoUrl: 'assets/icons/clean.png',),
    Chore(
      name: 'Balance',
      photoUrl: 'assets/icons/balance.png',
    ),
    Chore(
      name: 'Message',
      photoUrl: 'assets/icons/clean.png',
    ),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a ch'),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 50,child: Column(
              children: <Widget>[
                Row(children: <Widget>[CircleAvatar(),CircleAvatar(),]),
                Text('Amy'),
                Text('20.00')
              ],
            ),),
            GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                ...choresList.map((e) => Card(
                      child: InkWell(onTap: () {
                        setState(() {
                          choreName = e.name;
                        });
                      },
                                          child: Column(children: <Widget>[
                          Image.asset(e.photoUrl),
                          Text(e.name)
                        ]),
                      ),
                      
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
