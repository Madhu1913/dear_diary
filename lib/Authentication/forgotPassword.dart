import 'package:dear_diary/Authentication/Login.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:dear_diary/View/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _user=TextEditingController();
  Future PasswordReset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _user.text.trim());
      _user.clear();
      showDialog(context: context, builder: (context){
        return  const AlertDialog(
          content: Text('Password reset link sent!Check your Email',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
        );
      },
      );
    }on FirebaseAuthException catch (e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Dear Diary',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Get.off(()=>const login());
            },
            icon: const Icon(Icons.arrow_back,color: Colors.black,),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: h*0.2,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text('Enter your Email for a Password Reset Link',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: customTextField(
                validator: (val)=>null,
                color: Palatte.mainColor2,
                Seen: false,
                controller: _user,
                labelText: 'Email',
                keyboardType: TextInputType.text,
                maxLines: 1,
                prefixIcon: const Icon(Icons.mail,color: Palatte.mainColor2,),
              )
            ),
            Container(
                decoration: BoxDecoration(
                  color: Palatte.mainColor,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: TextButton(onPressed:PasswordReset, child: const Text('Reset Password',style: TextStyle(fontSize: 18,color: Palatte.mainColor2),),))
          ],
        ),
      ),
    );
  }
}
