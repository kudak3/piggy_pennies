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



class ChildAuth extends StatefulWidget {
  @override
  _ChildAuth createState() => _ChildAuth();
}


class _ChildAuth extends State<ChildAuth> {
  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
  FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();
  String email, password, confirmPassword, username;

  //pull list of chores
  Chore chore;
  List<Chore> choresList;
  List<Child> childList = [];
   List<Child> children;

  Widget viewProfileCard (){

    // choresList.add(new Chore(id:"1",name:'example',price:"50",dueDate:'12-01-12',frequency:"very",photoUrl:"jp/op",notes:"urgent"));

  }

   getChildren() async {
    var tmp = await firestoreService.getChildren();

    setState(() {
      children = tmp;
    
    });
  }

    Stream<List<Child>> list() async*{
      
        
        

           

          yield children;
      
        }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Column(
        children: [
          Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    initialData: list(),
                    stream: list(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData)
                        return Container(height: 1, width: 1);

                      List<Child> children = snapshot.data;
                      return listView(children);
                    }),
              ],
            ),
          ),


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
            Text(children[index].fullName,  style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold),),
          ],
        ),

      );
    },
  );

  @override
  void initState() {
    //pull chores and populate chore list
  }
}
