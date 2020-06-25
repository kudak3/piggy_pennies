import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/user.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/child/listgoal.dart';
import 'package:piggy_pennies/ui/parent/childchores.dart';

class ChildHome extends StatefulWidget {
  final String title;
  final Child child;
  ChildHome({Key key, this.title, this.child});

  @override
  ChildHomeState createState() => ChildHomeState();
}

class ChildHomeState extends State<ChildHome> {
  Child currentChild = Child();

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  User currentUser;
  Child selectedChild;
  List<Child> children = [];
  FirestoreService get firestoreService => GetIt.I<FirestoreService>();

  List menuList = [
    {'icon': 'assets/icons/clean.png', 'title': 'Chores'},
     {'icon': 'assets/icons/target.png', 'title': 'Wish List'},
  {'icon': 'assets/icons/target.png', 'title': 'Messages'},
    {'icon': 'assets/icons/target.png', 'title': 'Settings'},
   
    {'icon': 'assets/icons/balanced.png', 'title': 'Balance'},
    {'icon': 'assets/icons/target.png', 'title': 'Get Money out'},
       {'icon': 'assets/icons/icons8-safe-50.png', 'title': 'Put money in'},
   
  ];

  @override
  void initState() {
    currentChild = widget.child;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(38, 131, 138, 1),
        title: Text('Piggie Pennies'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(38, 131, 138, 1),
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        child: Text(
                          currentChild.fullName.substring(0, 2).toUpperCase(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        currentChild != null ? currentChild.fullName : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          currentChild != null
                              ? currentChild.balance != null
                                  ? "\$" + currentChild.balance.toString()
                                  : "\$0.00"
                              : "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: menuList
                    .map((e) => Card(
                          child: Center(
                            child: InkWell(
                              onTap: () {

                                page(e['title']);
                              },
                              child: Column(children: <Widget>[
                                Image.asset(
                                  e['icon'],
                                  height: 100,
                                  width: 100,
                                ),
                                Text(e['title'])
                              ]),
                            ),
                          ),
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }

  page(String page){

    if(page=='Chores'){
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChildChores(name: currentChild.fullName,),
      ),
    );
    }
    if(page=='Wish List'){
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListGoals(child: currentChild,),
      ),
    );
    }

  }

  listView(List<Child> children) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => null,
            leading: Icon(Icons.person),
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                SizedBox(height: 5.0),
                Text(children[index].fullName),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    SizedBox(height: 5.0),
                    Text(children[index].birthDate),
                  ],
                ),
                Text(children[index].gender),
              ],
            ),
          );
        },
      );
}
