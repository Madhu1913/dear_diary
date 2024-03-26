import 'package:dear_diary/InterFace/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class myDiary extends StatefulWidget {
  const myDiary({super.key});

  @override
  State<myDiary> createState() => _myDiaryState();
}

class _myDiaryState extends State<myDiary> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Diary'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.to(()=>HomePage());
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Text('Heyy'),
        ),
      ),
    );
  }
}
