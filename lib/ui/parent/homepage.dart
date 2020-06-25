import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/user.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/authentication/child_reg.dart';

import 'allowances.dart';
import 'my_kids.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Color primary = Colors.white;
  Color active = Colors.grey.shade800;
  Color divider = Colors.grey.shade600;

  Child currentSelectedChild;

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  User currentUser;
  Child selectedChild;
  List<Child> children;
  FirestoreService get firestoreService => GetIt.I<FirestoreService>();

  List menuList = [
    {'icon': 'assets/icons/target.png', 'title': 'Goal'},
    {'icon': 'assets/icons/target.png', 'title': 'Chores'},
    {'icon': 'assets/icons/target.png', 'title': 'Balance'},
    {'icon': 'assets/icons/target.png', 'title': 'Message'},
  ];

  @override
  void initState() {
    getCurrentUser();
    getChildren();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
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
              height: children ==null ? 100 :200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  children == null
                      ? Container(height: 0, width: 0)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: children
                              .map((e) => Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        child: Text(e.fullName.substring(0,2)),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ))
                              .toList()),
                  selectedChild != null
                      ? CircleAvatar(
                        radius: 30,
                          child: Text(selectedChild.fullName.substring(0,2).toUpperCase(),style: TextStyle(fontSize: 40),),
                        )
                      : Container(height: 0, width: 0),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    selectedChild != null ? selectedChild.fullName : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      selectedChild != null
                          ? "\$" + selectedChild.balance.toString()
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

  _buildDrawer() {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(currentUser.displayName),
                accountEmail: Text(currentUser.email),
                currentAccountPicture: CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyKids(),
                      ),
                    );
                  },
                  child: _buildRow(Icons.people, "My Kids")),
              Divider(color: divider),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Allowances(),
                    ),
                  );
                },
                child: _buildRow(Icons.monetization_on, "Allowances"),
              ),
              Divider(color: divider),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyKids(),
                    ),
                  );
                },
                child: _buildRow(Icons.settings, "Settings"),
              ),
              Divider(color: divider),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyKids(),
                    ),
                  );
                },
                child: _buildRow(Icons.exit_to_app, "Logout"),
              ),
              Divider(color: divider),
            ],
          )),
        ),
      ),
    );
  }

  _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: active,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
                color: Colors.deepOrange,
                elevation: 5.0,
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      '10',
                      style: TextStyle(
                        color: primary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )))
        ],
      ),
    );
  }

  getCurrentUser() async {
    var u = await authenticationService.currentUser();
    setState(() {
      currentUser = u;
    });
  }

  getChildren() async {
    var tmp = await firestoreService.getChildren();

    setState(() {
      children = tmp;
      selectedChild = tmp[0];
    });
  }
}
