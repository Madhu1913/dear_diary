import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/homePage.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../View/palatte.dart';

class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Dear Diary',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: () {
                Get.off(()=>const HomePage());
              },
            ),
            actions: [
              IconButton(
                  tooltip: 'Logout',
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
              }, icon: const Icon(Icons.logout,color: Colors.black,))
            ],
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser!.uid)
                .collection('Profile')
                .doc(currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return Consumer<firebaseMethods>(
                  builder: (context, value, child) => Column(
                    children: [
                      Center(
                        child: Stack(alignment: const Alignment(1, 1), children: [
                          Container(
                            decoration:BoxDecoration(
                              border: Border.all(
                                color: Palatte.mainColor2,
                                width: 4
                              ),
                              borderRadius: BorderRadius.circular(360)
                            ),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(data['img']),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color: Palatte.mainColor
                            ),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    value.selectProfileImage();
                                  },
                                  icon: const Icon(Icons.image,size:36,color: Palatte.mainColor2,)),
                            ),
                          )
                        ]),
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Palatte.mainColor,width: 3)
                          ),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(20),
                          child: Text(
                            'E-mail : ${currentUser!.email}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              color: Palatte.mainColor2,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
