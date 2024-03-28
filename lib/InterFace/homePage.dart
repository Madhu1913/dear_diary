import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/profile.dart';
import 'package:dear_diary/InterFace/reminders.dart';
import 'package:dear_diary/Locked/checkLock.dart';
import 'package:dear_diary/Locked/setLock.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/Provider/lockedDataProvider.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customImageview.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../View/palatte.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
   String mtoken='';
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
  void getToken()async{
     await FirebaseMessaging.instance.getToken().then((value){
       setState(() {
         mtoken=value!;
       });
       storeToken(value);
     });
  }
  void storeToken(token)async{
     await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection('Token').doc(currentUser!.email).set(
        {
          'Token':token
        });
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (val)async{
         false;
      },
      child: SafeArea(
        child: Consumer2<firebaseMethods,lockedData>(
          builder: (context, value,value2, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.person_outline_rounded,color: Colors.black,),
                onPressed: () {
                 Get.to(()=>const profileView());
                },
              ),
              title:const Text('Dear Diary ',style: TextStyle(color: Colors.black),),
              // centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      value.showCalender(context);
                    },
                    icon: const Icon(Icons.calendar_month_outlined,color: Colors.black,)),
                IconButton(
                    onPressed: () async{
                      await value.checkLock();
                      value.i==0
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('want to open LOCKED folder'),
                                    content: const Text("Locked folder let's you keep your data more safer"),
                                    actions: [
                                      customButton(
                                          color:Palatte.mainColor,
                                          onPressed: () {
                                            Get.to(()=>const setLock());
                                          },
                                          child: const Text('YES',style: TextStyle(color: Palatte.mainColor2,fontSize: 18),)),
                                      customButton(
                                        color:Palatte.mainColor,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('NO',style: TextStyle(color: Palatte.mainColor2,fontSize: 18),)),
                                    ],
                                  ))
                          : Get.to(()=>const checkLock());
                    },
                    icon: const Icon(Icons.lock_outline_rounded,color: Colors.black,)),
                IconButton(onPressed: (){
                  Get.to(()=>const addReminders());
                }, icon: const Icon(Icons.task_alt_rounded,color: Colors.black,))
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
                                    color: Palatte.mainColor2,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20), // Background color when swiping
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8),
                                    child: data[i]['differentiator'] == 1
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration:BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: Palatte.mainColor
                                                  ),
                                                  padding: const EdgeInsets.all(6),
                                                  child: Text(data[i]['Time'],style: const TextStyle(color: Palatte.mainColor2),)),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Palatte.white, // Background color when swiping
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                      12),
                                                              topLeft:
                                                                  Radius.circular(
                                                                      12),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      12)),
                                                  border: Border.all(color: Palatte.mainColor2)
                                                  ),
                                                  child: Text(
                                                    data[i]['note'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Palatte.mainColor2),
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
                                                child: Hero(
                                                  tag: 1,
                                                  child: Container(
                                                    height: h * 0.25,
                                                    width: h * 0.25,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Palatte.mainColor2),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                data[i]['note']),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                            const BorderRadius.only(
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
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Palatte.mainColor,
                                                    borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  padding: const EdgeInsets.all(6),
                                                  child: Text(data[i]['Time'],style: const TextStyle(color: Palatte.mainColor2),)),
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
                      return const Center(
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
                    minWidth: w*0.78,
                    maxWidth: w*0.78,
                    minHeight: 25.0,
                    maxHeight: 150.0,
                  ),
                          child: Scrollbar(
                            child: customTextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                                suffixIcon: IconButton(
                                  onPressed: value.selectImage,
                                  icon: const Icon(
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
                            onPressed: (){
                              value.addToDB();
                            },
                            icon: const Icon(
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
      ),
    );
  }
}
