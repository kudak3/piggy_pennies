import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/service.dart/authentication_service.dart';
import 'package:piggy_pennies/service.dart/firestore_service.dart';
import 'package:piggy_pennies/ui/authentication/child_reg.dart';


class MyKids extends StatefulWidget {
  // MyKids({this.childlist});

  _MyKidsState createState() => _MyKidsState();
}

class _MyKidsState extends State<MyKids> {
  Stream<List<Child>> childlist;
  List<Child> children =[];

  bool _isLoading = false;

 

  AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();
        FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();
  String email, password, confirmPassword, username;

  @override
  initState(){
getChildren();
print(children);
    super.initState();
  }

 getChildren() async {
    var tmp = await firestoreService.getChildren();

    setState(() {
      children = tmp;
    
    });
  }

   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Kids"),
      ),
      body: Container(
        
        margin: const EdgeInsets.only(
            top: 50, left: 16.0, right: 16.0, bottom: 10.0),
        child: _isLoading
            ? Center(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    
                         Container(height: 300,child:listView(children))
                        ,
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color.fromRGBO(38, 131, 138,1),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChildReg(newacc: false,),
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
    );
  }

  listView(List<Child> children) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => null,
            leading: Icon(Icons.person,color: Color.fromRGBO(38, 131, 138,1),),
            title: Row(
              children: <Widget>[
                Icon(Icons.person,color: Color.fromRGBO(38, 131, 138,1),),
                SizedBox(height: 10.0),
                Text(children[index].fullName),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today,color: Color.fromRGBO(38, 131, 138,1),),
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

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.green,
        fontSize: 16.0);
  }

  
}
