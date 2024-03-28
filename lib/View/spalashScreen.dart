import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Authentication/authPage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  Animation<double>? _scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scale = Tween<double>(
      begin:  0.0,
      end:  1.2,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));
    _controller!.forward();
    Timer(const Duration(milliseconds: 1600), () => Get.to(()=>const AuthPage()));

  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(
      body: Center(
        child:ScaleTransition(
          scale: _scale!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:w*0.7,
                width: w*0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/appicon.png'),
                  fit: BoxFit.fill)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dear ',style: TextStyle(fontSize: 40,color: Colors.amber.shade700),),
                  Text('Diary',style: TextStyle(fontSize: 40,color: Colors.deepPurple[700]),)
                ],
              )
            ],

          ),
        ),
      ),
    ));
  }
}
