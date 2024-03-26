import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            title: Text('Dear Diary'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
              }, icon: Icon(Icons.logout))
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
                        child: Stack(alignment: Alignment(1, 1), children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(data['img']),
                          ),
                          customButton(
                              onPressed: () {
                                value.selectProfileImage();
                              },
                              child: Icon(Icons.add))
                        ]),
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.red),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          child: Text(
                            '${currentUser!.email}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
