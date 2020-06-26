import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/allowance.dart';

import 'package:piggy_pennies/service.dart/firestore_service.dart';


class Allowances extends StatefulWidget {

  final String name;

  Allowances({this.name});
  _AllowancesState createState() => _AllowancesState();
}

class _AllowancesState extends State<Allowances> {
    List<Allowance> allowances = [];

    FirestoreService get firestoreService =>
      GetIt.I<FirestoreService>();

      @override
  void initState() {
    getAllowances();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(text: 'Unpaid',),
          Tab(text:'paid'),
          
        ],
      ),
    ),
    body: TabBarView(
            children: [
                SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                   
                          Container(child:listView(allowances)),
                        
                    SizedBox(
                      height: 10.0,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   width: double.infinity,
                    //   child: RaisedButton(
                    //     color: Colors.green,
                    //     textColor: Colors.white,
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (_) => ChildReg(),
                    //         ), 
                    //       );
                    //     },
                    //     padding: EdgeInsets.only(
                    //         left: 30.0, right: 30.0, top: 16.0, bottom: 16.0),
                    //     child: Text('Add a Child'),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30.0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
               SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    
                        Container(child:listView(allowances),),
                      
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

    listView(List<Allowance> allowances) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        scrollDirection: Axis.vertical,
        itemCount: allowances.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => null,
            leading: Text(allowances[index].chore.dueDate),
            title: Row(
              children: <Widget>[
              
                Text(allowances[index].chore.assignees[0].fullName,style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                  
                    Text(allowances[index].chore.name),
                  ],
                ),
               
              ],
              
            ),
            trailing:  Text(allowances[index].chore.price),
          );
        },
      );

  
   getAllowances() async {
     var tmp;
     if(widget.name!=null){
     tmp = await firestoreService.getAllowances(widget.name);
     }else{
           tmp = await firestoreService.getAllAllowances();
     }



    setState(() {
      allowances = tmp;
        });
  }
  
}
