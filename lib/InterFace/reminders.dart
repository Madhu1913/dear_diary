import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Notifications/firebaseApi.dart';
import 'package:dear_diary/Provider/lockedDataProvider.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../View/palatte.dart';

class addReminders extends StatefulWidget {
  const addReminders({super.key});

  @override
  State<addReminders> createState() => _addRemindersState();
}

class _addRemindersState extends State<addReminders> {
  final task = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<lockedData>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'My Reminders',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.off(() => HomePage());
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser!.uid)
                .collection('Reminders')
                .orderBy('TimeStamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      String id = data[i].id;
                      return Container(
                        decoration: BoxDecoration(
                          color: Palatte.mainColor,
                          border:
                              Border.all(color: Palatte.mainColor2, width: 2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[i]['Task'],
                                  style: TextStyle(
                                      color: Palatte.mainColor2,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(currentUser!.uid)
                                          .collection('Reminders')
                                          .doc(id)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Palatte.buttonColor,
                                      size: 30,
                                    ))
                              ],
                            ),
                            Text(
                              data[i]['Time'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Palatte.mainColor,
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Add Reminder?'),
                        content: Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 200,
                              minHeight: 20,
                              maxWidth: 200,
                              maxHeight: 160
                            ),
                            child: Scrollbar(
                              child: customTextField(
                                maxLines: null,
                                color: Palatte.mainColor2,
                                controller: task,
                                validator: (val) =>
                                    val!.isEmpty ? 'Please enter a Reminder' : null,
                                labelText: 'Reminder',
                                Seen: false,
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    onChanged: (val) => date = val,
                                    onConfirm: (val) {});
                              },
                              icon: Icon(Icons.calendar_month_outlined,color: Palatte.mainColor2,)),
                          customButton(
                              color: Palatte.mainColor,
                              onPressed: () {
                                if(date!=null){
                                  value.addTaskTodb(task.text.trim(), date!);
                                  Random random = new Random();
                                  int randomNumber = random.nextInt(1000);

                                  FirebaseApi().scheduleNotification(
                                      id: randomNumber,
                                      title: 'Reminder',
                                      body: task.text.trim(),
                                      scheduledNotificationDateTime: date!);
                                  task.clear();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Add',style: TextStyle(color: Palatte.mainColor2),)),
                          customButton(
                              color: Palatte.mainColor,
                              onPressed: () {
                                task.clear();
                                Navigator.pop(context);
                              },
                              child: Text('Cancel',style: TextStyle(color: Palatte.mainColor2),))
                        ],
                      ));
            },
            child: Icon(Icons.add,color: Palatte.mainColor2,size: 30,),
          ),
        ),
      ),
    );
  }
}
