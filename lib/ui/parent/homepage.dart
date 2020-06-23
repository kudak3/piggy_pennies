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

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  User currentUser;
    FirestoreService get firestoreService => GetIt.I<FirestoreService>();

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  getCurrentUser() async {
  setState(() async* {
     currentUser =await authenticationService.currentUser();
  });
   
    print(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Piggy Pennies'),
            ),
          ),
          SliverFillRemaining(
            child:  Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
            top: 10, left: 16.0, right: 16.0, bottom: 10.0),
        child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: firestoreService.getChildrenByParentId(),
                        stream: firestoreService.getChildrenByParentId(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Child> children = snapshot.data;
                          return listView(children);
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChildReg(),
                            ),
                          );
                        },
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                        child: Text('Add a Child'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
          )
        ],
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
}
