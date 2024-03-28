import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Locked/lockedHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/palatte.dart';

class checkLock extends StatefulWidget {
  const checkLock({super.key});

  @override
  State<checkLock> createState() => _checkLockState();
}

class _checkLockState extends State<checkLock> {
  List data = [];
  String note = 'Enter Password';
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('My Diary',style: TextStyle(fontSize: 26,color: Colors.black),),
          centerTitle: true,
          leading: IconButton(
            tooltip: 'Back',
            onPressed: () {
             Get.off(()=>const HomePage());
            },
            icon: const Icon(Icons.arrow_back,color: Colors.black,),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Palatte.mainColor,width: 2)
                    ),
                    padding: const EdgeInsets.all(20),
                    // margin: EdgeInsets.all(10),
                    child: Text(
                      note,
                      style: const TextStyle(
                          color: Palatte.mainColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    data.join("  "),
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              color:Palatte.mainColor2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          child: const Text(
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
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 40),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(currentUser!.uid)
                            .collection('Lock')
                            .doc(currentUser!.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          var password = snapshot.data!['lock'];
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Palatte.mainColor,width: 2)
                            ),
                            child: TextButton(

                              onPressed: () async {
                                if (const ListEquality().equals(password, data)) {
                                  Get.to(() => const myDiary());
                                } else {
                                  note = 'Please enter correct password';
                                }
                                setState(() {});
                              },
                              child: const Text('OK',style: TextStyle(color: Palatte.mainColor2,fontSize: 20)),
                            ),
                          );
                        }),
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
                        child: const Text('Delete',style: TextStyle(color: Palatte.mainColor2,fontSize: 20)),
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
