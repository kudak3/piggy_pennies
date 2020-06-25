import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/user.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';




class ChildHome extends StatefulWidget {
  ChildHome({Key key, this.title,this.child}) : super(key: key);

  final String title;
  final Child child;

  @override
  ChildHomeState createState() => ChildHomeState();
}

class ChildHomeState extends State<ChildHome> {
 
  Child currentChild;

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  User currentUser;
  Child selectedChild;
  List<Child> children =[];
  FirestoreService get firestoreService => GetIt.I<FirestoreService>();

  List menuList = [
     {'icon': 'assets/icons/clean.png', 'title': 'Chores'},
    {'icon': 'assets/icons/target.png', 'title': 'Put money in'},
       {'icon': 'assets/icons/target.png', 'title': 'Wish List'},
    {'icon': 'assets/icons/balanced.png', 'title': 'Balance'},
    {'icon': 'assets/icons/target.png', 'title': 'Get Money out'},
     {'icon': 'assets/icons/target.png', 'title': 'Messages'},
         {'icon': 'assets/icons/target.png', 'title': 'Settings'},

  ];

  @override
  void initState() {


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
              height:  200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                 
                  
                      CircleAvatar(
                          radius: 30,
                          child: Text(
                            currentChild.fullName
                                .substring(0, 2)
                                .toUpperCase(),
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
    
                  SizedBox(
                    height: 20,
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
            ),
            GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                children: menuList
                    .map((e) => Card(
                          child: Center(
                            child: InkWell(
                              onTap: () {},
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
