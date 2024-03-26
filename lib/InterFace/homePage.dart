import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/profile.dart';
import 'package:dear_diary/Locked/checkLock.dart';

import 'package:dear_diary/Locked/setLock.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customImageview.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Consumer<firebaseMethods>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.person_outline_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileView()));
              },
            ),
            title: Text('Dear Diary    '),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    value.showCalender(context);
                  },
                  icon: Icon(Icons.calendar_month_outlined)),
              IconButton(
                  onPressed: () async{
                    await value.checkLock();
                    await value.i==0
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('want a LOCKED folder'),
                                  actions: [
                                    customButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      setLock()));
                                        },
                                        child: Text('YES')),
                                    customButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('NO'))
                                  ],
                                ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => checkLock()));
                  },
                  icon: Icon(Icons.lock_outline_rounded))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser!.uid)
                      .collection(value.dateformatter.format(DateTime.now()))
                      .orderBy('TimeStamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            // reverse: true,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              final data = snapshot.data!.docs;
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (left) {
                                  var id = data[i].id;
                                  value.deleteItem(id);
                                },
                                background: Container(
                                  color: Colors
                                      .red, // Background color when swiping
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 8),
                                  child: data[i]['differentiator'] == 1
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data[i]['Time']),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Flexible(
                                              child: Container(
                                                // width: w*0.7,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    16),
                                                            topLeft:
                                                                Radius.circular(
                                                                    16),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    16))),
                                                child: Text(
                                                  data[i]['note'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            customImageView(
                                                                img: data[i]
                                                                    ['note'])));
                                              },
                                              child: Container(
                                                height: h * 0.25,
                                                width: h * 0.25,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            data[i]['note']),
                                                        fit: BoxFit.cover),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    32),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    32),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    32))),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(data[i]['Time']),
                                          ],
                                        ),
                                ),
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Form(
                        key: value.key,
                        child: customTextField(
                            suffixIcon: IconButton(
                              onPressed: value.selectImage,
                              icon: Icon(
                                Icons.image,
                                color: Colors.red,
                              ),
                            ),
                            controller: value.note,
                            labelText: 'Enter here...',
                            validator: (val) =>
                                val!.isEmpty ? 'Please Enter Something' : null,
                            color: Colors.red,
                            Seen: false),
                      ),
                    ),
                    customButton(
                        onPressed: value.addToDB,
                        child: Icon(
                          Icons.done,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
