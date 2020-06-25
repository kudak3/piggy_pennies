import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';


class ChildChores extends StatefulWidget {
  final String childId;
  final String name;
  ChildChores({this.childId,this.name});
  _ChildChoresState createState() => _ChildChoresState();
}

class _ChildChoresState extends State<ChildChores> {
  

    FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(text: 'UnApproved',),
          Tab(text:'Pending'),
          Tab(text:'Completed'),
          
        ],
      ),
    ),
    body: TabBarView(
            children: [
                SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: [],
                        stream: firestoreService.getChores('unapproved',widget.childId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Chore> chores = snapshot.data;
                          return listView(chores);
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
                        
                        },
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                        child: Text('Approve'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: firestoreService.getAllowancesByChildId(),
                        stream: firestoreService.getChores('pending',widget.childId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Chore> chores = snapshot.data;
                          return listView(chores);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                   
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        initialData: [],
                        stream: firestoreService.getChores('completed',widget.childId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 1, width: 1);

                          List<Chore> chores = snapshot.data;
                          return listView(chores);
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

    listView(List<Chore> chores) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: chores.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => null,
            leading: Text(chores[index].name),
            title: Row(
              children: <Widget>[
              
                Text(chores[index].price,style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                  
                    Text(chores[index].dueDate),
                  ],
                ),
               
              ],
              
            ),
            trailing:  Text(chores[index].price),
          );
        },
      );

  
  
}
