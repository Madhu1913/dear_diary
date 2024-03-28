import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/View/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../View/customImageview.dart';

class previousNotes extends StatefulWidget {
  final String date;

  const previousNotes({super.key, required this.date,});

  @override
  State<previousNotes> createState() => _previousNotesState();
}

class _previousNotesState extends State<previousNotes> {
  int? i;
  bool isLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getdata();
  }
  Future getdata()async{
    await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection(widget.date).get().then((value){
      if(value.docs.length!=0){
       i=1;
      }else{
    i=0;
      }
     setState(() {
       isLoading=false;
     });
    });

  }
  final currentUser=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    return SafeArea(
        child: Consumer<firebaseMethods>(
          builder: (context,value,child)=>Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Dear Diary',style: TextStyle(color: Colors.black),),centerTitle: true,leading: IconButton(
              onPressed: (){
                Get.off(()=>HomePage());
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),),
                body:  isLoading ? Center(child:CircularProgressIndicator()):i==1?StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser!.uid)
                .collection(widget.date)
                .orderBy('TimeStamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  // reverse: true,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      final data = snapshot.data!.docs;
                      return Padding(
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
                                        topRight: Radius
                                            .circular(32),
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
            }):Center(
                  child: Text('No data found'),
                ),
              ),
        ));
  }
}
