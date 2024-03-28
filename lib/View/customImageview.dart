import 'package:dear_diary/InterFace/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class customImageView extends StatelessWidget {
 final  String img;
  const customImageView({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dear Diary',style: TextStyle(color: Colors.black),),
          elevation: 0,
          leading: IconButton(onPressed: (){
            Get.off(()=>const HomePage());
          },
            tooltip: 'Back',

            icon: const Icon(Icons.arrow_back,color: Colors.black,),),
        ),
        body: Hero(
          tag: 1,
          child: Center(
            child: Container(
              height: h*0.5,
              width: h*0.5,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(img))),
            ),
          ),
        ),
      ),
    );
  }
}
