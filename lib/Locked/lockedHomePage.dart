import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Provider/lockedDataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../View/customButton.dart';
import '../View/customImageview.dart';
import '../View/customTextField.dart';
import '../View/palatte.dart';

class myDiary extends StatefulWidget {
  const myDiary({super.key});

  @override
  State<myDiary> createState() => _myDiaryState();
}

class _myDiaryState extends State<myDiary> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Consumer<lockedData>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('My Diary',style: TextStyle(fontSize: 26,color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.off(() => HomePage());
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    value.showCalender(context);
                  },
                  icon: Icon(Icons.calendar_month_outlined,color: Colors.black,))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser!.uid)
                      .collection(
                          'Locked-${value.dateformatter.format(DateTime.now())}')
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
                                  color: Palatte.mainColor2, // Background color when swiping

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
                                                    color: Palatte.mainColor2,

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
                                                Get.to(()=>customImageView(img: data[i]
                                                ['note']));
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
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 150,
                          maxWidth: w*0.78,
                          minHeight: 25,
                          minWidth: w*0.78
                        ),
                        child: Scrollbar(
                          child: customTextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                              suffixIcon: IconButton(
                                onPressed: value.selectImage,
                                icon: Icon(
                                  Icons.image,
                                  color: Palatte.mainColor2,
                                ),
                              ),
                              controller: value.note,
                              labelText: 'Enter here...',
                              validator: (val) =>
                                  val!.isEmpty ? 'Please Enter Something' : null,
                              color: Palatte.mainColor2,
                              Seen: false),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: Palatte.mainColor2
                          )
                      ),
                      child: IconButton(
                          onPressed: value.addToDB,
                          icon: Icon(
                            Icons.done_outline_rounded,
                            color: Palatte.mainColor2,
                          )),
                    )
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
