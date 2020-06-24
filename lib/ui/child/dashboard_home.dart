import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/ui/child/widgets/bottom_drawer.dart';
import 'package:piggy_pennies/ui/child/widgets/side_drawer.dart';

import '../../model/child.dart';
import '../../model/chore.dart';
import '../../model/chore.dart';
import '../../model/goal.dart';
import '../../service.dart/authentication_service.dart';
import '../../service.dart/firestore_service.dart';



class ChildDashboard extends StatefulWidget {
  @override
  _ChildDashboard createState() => _ChildDashboard();
}


class _ChildDashboard extends State<ChildDashboard> {
  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();
  String email, password, confirmPassword, username;

  //pull list of chores
  Chore chore;
  List<Chore> choresList;

  Widget Goalone(){
    return ListTile(
      onTap: () => null,
      leading: Icon(Icons.person),
      title: Row(
        children: <Widget>[
          Icon(Icons.person),
          SizedBox(height: 5.0),
          Text("Wash the dishes"),
        ],
      ),
      subtitle: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.monetization_on),
              SizedBox(height: 5.0),
              Text("Amount: 200"),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
              SizedBox(height: 5.0),
              Text("Due date: 12/07/20"),
            ],
          )
        ],
      ),
    );
  }

  Widget Goaltwo(){
    return ListTile(
      onTap: () => null,
      leading: Icon(Icons.person),
      title: Row(
        children: <Widget>[
          Icon(Icons.person),
          SizedBox(height: 5.0),
          Text("Clean the House"),
        ],
      ),
      subtitle: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.monetization_on),
              SizedBox(height: 5.0),
              Text("Amount: 16"),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
              SizedBox(height: 5.0),
              Text("Due date: 12/07/20"),
            ],
          )

        ],
      ),
    );
  }

  Widget viewProfileCard (){

   // choresList.add(new Chore(id:"1",name:'example',price:"50",dueDate:'12-01-12',frequency:"very",photoUrl:"jp/op",notes:"urgent"));

    return Column(
      children: [
        Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right:
                              new BorderSide(width: 3.0, color: Colors.white24))),
                      child: Icon(Icons.account_circle, color: Colors.yellow),
                    ),
                    title: Text(
                      "Available Balance:   ${100}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text("View and edit profile",
                            style: TextStyle(color: Colors.white,fontSize: 10.0))
                      ],
                    ),
                    trailing: Icon(Icons.monetization_on,
                        color: Colors.yellow, size: 30.0),

                  )
              ),
//              StreamBuilder(
//                  initialData: firestoreService.getChildrenByParentId(),
//                  stream: firestoreService.getChildrenByParentId(),
//                  builder:
//                      (BuildContext context, AsyncSnapshot snapshot) {
//                    if (!snapshot.hasData)
//                      return Container(height: 1, width: 1);
//
//                    List<Child> children = snapshot.data;
//                    return listView(children);
//                  }),
              SizedBox(
                height: 10.0,
              ),

            ],
          ),
        ),


      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      child: Stack(
        children: <Widget>[
//          Center(
//            child: Center(
//              child: Image.asset(
//                  'assets/zupco backg.jpg',
//                width: size.width,
//                height: size.height,
//              ),
//            ),
//          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[

              viewProfileCard(),
              Goalone(),
              Goaltwo(),

            ],
          ),
        ],
      ),


    );
  }

  @override
  void initState() {
  //pull chores and populate chore list
  }
}
