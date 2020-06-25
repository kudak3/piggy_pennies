import 'package:flutter/material.dart';
import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/ui/parent/chore_price.dart';

class ChooseChore extends StatefulWidget {
  _ChooseChoreState createState() => _ChooseChoreState();
}

class _ChooseChoreState extends State<ChooseChore> {
  String choreName;
  List<Chore> choresList = [
    Chore(
      id: '1',
      name: 'Brush teeth',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Feed pets',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Pull Laundry in Hamper',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Make bed',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Put away toys',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Clear the table',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Do Homework',
      photoUrl: 'assets/icons/clean.png',
    ),
    Chore(
      name: 'Take out the table',
      photoUrl: 'assets/icons/clean.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a chore'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              top: 10, left: 16.0, right: 16.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
                  Column(
                      children: <Widget>[
              Text(
                'Select a chore',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height:10.0),
              Text('Choose a chore by clicking a picture or adding a new one',style: TextStyle(fontSize: 12),),
                SizedBox(height:20.0),],),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: choresList
                    .map(
                      (e) => Card(
                        
                        elevation: 2.0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              choreName = e.name;
                            });
                             _next();
                          },
                          child: Stack(children: <Widget>[
                            // Image.asset(e.photoUrl),
                             Positioned.fill(
                          bottom: 10.0,
                          child: Align(
                            alignment: Alignment.center,
                            child:  Text(e.name,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                        )
                              ]),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20.0,),
            
            ],
          ),
        ),
      ),
    );
  }

  _next() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChorePrice(chorename: choreName),
      ),
    );
  }
}
