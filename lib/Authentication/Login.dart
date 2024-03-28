import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../View/palatte.dart';

class login extends StatefulWidget {
  final Function()? onTap;

  const login({super.key, this.onTap});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final key1 = GlobalKey<FormState>();
  void Login() async {
    if (key1.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        if (context.mounted) {
          Navigator.pop(context);
        }
        email.clear();
        password.clear();
      } on FirebaseAuthException catch (er) {
        Navigator.pop(context);
        errorMessage(er.code);
      }
    }
  }

  void errorMessage(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Center(
                child: Text(
              msg,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            )),
          );
        });
  }
  bool isSeen = true;
  IconData icn = Icons.visibility;

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.15,
                ),
                Container(
                  height:w*0.4,
                  width: w*0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/appicon.png'),
                          fit: BoxFit.fill)
                  ),
                ),
                // SizedBox(height: w*0.04,),
                Text('Dear Diary',style: TextStyle(fontSize: 32,fontWeight: FontWeight.w500),),
                customTextField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  Seen: false,
                    prefixIcon: Icon(Icons.email,color: Palatte.mainColor2,),
                    controller: email,
                    labelText: 'Enter Your Email',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter Your Email';
                      } else if (!val.endsWith('@gmail.com')) {
                        return 'Please enter a valid Email';
                      } else {
                        return null;
                      }
                    },
                  color: Palatte.mainColor2,
                ),
                customTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,

                  Seen: isSeen,
                    prefixIcon: Icon(Icons.password,color: Palatte.mainColor2,),
                    suffixIcon: InkWell(
                        onTap: () {
                          isSeen = !isSeen;
                          setState(() {
                            if (isSeen == true) {
                              icn = Icons.visibility;
                            } else {
                              icn = Icons.visibility_off;
                            }
                          });
                        },
                        child: Icon(icn,
                          color: Palatte.mainColor2,
                        )),
                    controller: password,
                    labelText: 'Enter Your Password',
                    validator: (val){
                      if(val!.isEmpty){
                        return 'Please Enter Password';
                      }else if(val.length<6){
                        return 'Please Enter Valid Password';
                      }else{
                        return null;
                      }
                    },
                  color: Palatte.mainColor2,
                ),
                SizedBox(
                  height: 20,
                ),
                customButton(
                    color: Palatte.buttonColor,
                    onPressed: Login, child: Text('Login')),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a Registered user?'),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                        onTap: widget.onTap,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Palatte.mainColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
