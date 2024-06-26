import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/Locked/lockedHomePage.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/View/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../View/customImageview.dart';

class lockedPreviousNotes extends StatefulWidget {
  final String date;

  const lockedPreviousNotes({super.key, required this.date, });

  @override
  State<lockedPreviousNotes> createState() => _lockedPreviousNotesState();
}

class _lockedPreviousNotesState extends State<lockedPreviousNotes> {
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
      if(value.docs.isNotEmpty){
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
              title: const Text('Dear Diary',style: TextStyle(color: Colors.black),),centerTitle: true,leading: IconButton(
              onPressed: (){
                Get.off(()=>const myDiary());
              },
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
            ),),
            body:  isLoading ? const Center(
              child: CircularProgressIndicator(),
            ):i==1?StreamBuilder(
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Container(
                                    // width: w*0.7,
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
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
                                      style: const TextStyle(
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
                                        const BorderRadius.only(
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
                                const SizedBox(
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

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }):const Center(
              child: Text('No data found'),
            ),
          ),
        ));
  }
}
