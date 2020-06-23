import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/allowance.dart';
import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/parent/chore_price.dart';

import 'homepage.dart';

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

    FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(text: 'Unpaid',),
          Tab(text:'paid'),
          
        ],
      ),
    ),
    body: TabBarView(
            children: [
                SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: firestoreService.getAllowancesByChildId(),
                        stream: firestoreService.getAllowancesByChildId(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Allowance> allowances = snapshot.data;
                          return listView(allowances);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   width: double.infinity,
                    //   child: RaisedButton(
                    //     color: Colors.green,
                    //     textColor: Colors.white,
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (_) => ChildReg(),
                    //         ), 
                    //       );
                    //     },
                    //     padding: EdgeInsets.only(
                    //         left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                    //     child: Text('Add a Child'),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30.0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
               SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: firestoreService.getAllowancesByChildId(),
                        stream: firestoreService.getAllowancesByChildId(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Allowance> allowances = snapshot.data;
                          return listView(allowances);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () {

                          _next();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => HomePage(),
                          //   ), 
                          // );
                        },
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                        child: Text('Pay Child'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
           
            ],
          ),
  ),
);

    }

    listView(List<Allowance> allowances) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: allowances.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => null,
            leading: Text(allowances[index].chore.dueDate),
            title: Row(
              children: <Widget>[
              
                Text(allowances[index].chore.assignees[0].fullName,style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                  
                    Text(allowances[index].chore.name),
                  ],
                ),
               
              ],
              
            ),
            trailing:  Text(allowances[index].chore.price),
          );
        },
      );

  _next() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChorePrice(chorename: choreName),
      ),
    );
  }
}
