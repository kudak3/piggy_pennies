import 'package:flutter/material.dart';
import 'package:piggy_pennies/ui/child/widgets/bottom_drawer.dart';
import 'package:piggy_pennies/ui/child/widgets/side_drawer.dart';

import '../../model/chore.dart';
import '../../model/chore.dart';
import '../../model/goal.dart';



class ChildDashboard extends StatefulWidget {
  @override
  _ChildDashboard createState() => _ChildDashboard();
}


class _ChildDashboard extends State<ChildDashboard> {
  //pull list of chores
  Chore chore;
  List<Chore> choresList;

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
//            onTap: () {
//              Navigator.push(context, MaterialPageRoute(
//                  builder:(context) => MapUI()
//              ));
//
//            },
                  )
              ),

            ],
          ),
        ),
        new Expanded(
            child: new ListView.builder
              (
                itemCount: choresList.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return new ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right:
                              new BorderSide(width: 3.0, color: Colors.white24))),
                      child: Icon(Icons.center_focus_strong, color: Colors.yellow),
                    ),
                    title: Column(
                      children: <Widget>[
                        Text(
                          "${choresList[Index].name}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${choresList[Index].price}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text("Due date: ${choresList[Index].dueDate}", style: TextStyle(color: Colors.white)),

                    trailing: Icon(Icons.monetization_on,
                        color: Colors.yellow, size: 30.0),

                  );
                }
            )
        )

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
