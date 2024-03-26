import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Locked/checkLock.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'confirmLock.dart';
class setLock extends StatefulWidget {
  const setLock({super.key});

  @override
  State<setLock> createState() => _setLockState();
}

class _setLockState extends State<setLock> {
  List data=[];
  String note='Please put a password of 4 digits';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('My Diary'),centerTitle: true,leading: IconButton(onPressed: (){
         Get.to(()=>HomePage());
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
                       if(data.length>4){
                         note='Please enter 4 digits only';
                       }else if(data.length<4){
                         note='Please enter all the 4 digits';
                       }else {
                         Navigator.push(context, MaterialPageRoute(
                             builder: (context) => confirmLock(originaldata: data)));
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
