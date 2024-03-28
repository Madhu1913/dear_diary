

import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Locked/checkLock.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../View/palatte.dart';
import 'confirmLock.dart';

class setLock extends StatefulWidget {
  const setLock({super.key});

  @override
  State<setLock> createState() => _setLockState();
}

class _setLockState extends State<setLock> {
  List data = [];
  String note = 'Please put a password of 4 digits';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('My Diary',style: TextStyle(color: Colors.black,fontSize: 26),),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.off(() => HomePage());
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Palatte.mainColor,width: 2)
                    ),
                    padding: EdgeInsets.all(20),
                    // margin: EdgeInsets.all(10),
                    child: Text(
                      note,
                      style: TextStyle(
                          color: Palatte.mainColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    data.join("  "),
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Palatte.mainColor2,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          data.add(9);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '9',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          data.add(8);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '8',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          data.add(7);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '7',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          data.add(6);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '6',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          data.add(5);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '5',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          data.add(4);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '4',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          data.add(3);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '3',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          data.add(2);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '2',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          data.add(1);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palatte.mainColor,width: 2)
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        data.add(0);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Palatte.mainColor,width: 2)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        margin: EdgeInsets.all(10),
                        child: Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 40),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Palatte.mainColor,width: 2)
                      ),
                      // padding: EdgeInsets.all(20),
                      // margin: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          if (data.length > 4) {
                            note = 'Please enter 4 digits only';
                          } else if (data.length < 4) {
                            note = 'Please enter all the 4 digits';
                          } else {
                            Get.to(() => confirmLock(originaldata: data));
                          }
                          setState(() {});
                        },
                        child: Text('OK',style: TextStyle(color: Palatte.mainColor2,fontSize: 20),),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Palatte.mainColor,width: 2)
                      ),

                      child: TextButton(
                        onPressed: () {
                          data.removeLast();
                          setState(() {});
                        },
                        child: Text('Delete',style: TextStyle(color: Palatte.mainColor2,fontSize: 20),),
                      ),
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
