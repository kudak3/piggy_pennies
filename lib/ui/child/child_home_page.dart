import 'package:flutter/material.dart';
import 'package:piggy_pennies/ui/child/dashboard_home.dart';
import 'package:piggy_pennies/ui/child/transactions.dart';
import 'package:piggy_pennies/ui/child/widgets/side_drawer.dart';

import '../../model/child.dart';

class ChildHome extends StatefulWidget {

  @override
  _ChildHome createState() => _ChildHome();
}

class _ChildHome extends State<ChildHome> {
  Child child =new Child();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.business_center)),
                Tab(icon: Icon(Icons.monetization_on)),
              ],
            ),
            title: Container(child: Row(children: <Widget>[Text('Hie ${child.fullName}')],),),
          ),
          body: TabBarView(
            children: [
              ChildDashboard(),
              Transactions(),
              Icon(Icons.directions_bike),
            ],
          ),
          drawer: SideDrawer(),
        ),
      ),
    );
  }

  @override
  void initState() {
    //pull child details
    child.fullName = 'jane';
    child.birthDate = '5-06-90';
  }
}