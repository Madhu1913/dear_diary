import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/Locked/lockedHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/customButton.dart';
class confirmLock extends StatefulWidget {
  final List originaldata;
  const confirmLock({super.key, required this.originaldata});

  @override
  State<confirmLock> createState() => _confirmLockState();
}

class _confirmLockState extends State<confirmLock> {
  List data=[];
  String note='Please enter password again';
  final currentUser=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('My Diary'),centerTitle: true,leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back),),),
        body: Column(
          children: [
            SizedBox(height: 60,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text(note,style: TextStyle(color: Colors.red,fontSize: 23,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 40,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(data.join("  "),style: TextStyle(fontSize: 30),),
                ],
              ),
            ),
            Divider(thickness: 2,color: Colors.red,indent: 20,endIndent: 20,),
            SizedBox(height: 10,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          data.add(9);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('9',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          data.add(8);
                          setState(() {
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('8',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          data.add(7);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('7',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          data.add(6);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('6',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          data.add(5);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('5',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          data.add(4);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('4',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          data.add(3);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('3',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          data.add(2);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('2',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          data.add(1);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text('1',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        data.add(0);
                        setState(() {

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        child: Text('0',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 40),),
                      ),
                    ),
                    customButton(onPressed: (){
                        if(ListEquality().equals(data, widget.originaldata)){
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: Text('Set password'),
                            content: Text("Don't forget your password\nNo password No access to locked folder"),
                            actions: [
                              customButton(onPressed: ()async{
                                await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection('Lock').doc(currentUser!.email).set(
                                    {
                                      'lock':data
                                    }).then((value){
                                      Get.to(()=>myDiary());
                                });
                              }, child: Text('SET')),
                              customButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('Back')),
                            ],
                          ));
                        }else{
                          note='Enter same as previous';
                        }
                        setState(() {

                        });
                    },child: Text('OK'),
                    ),
                    customButton(onPressed: (){
                      data.removeLast();
                      setState(() {
                      });
                    },child: Text('Delete'),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
