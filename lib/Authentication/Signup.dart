import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:dear_diary/View/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  final Function()? onTap;

  const signUp({super.key, this.onTap});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final mail = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool isSeen1 = true;
  bool isSeen2 = true;
  IconData icn1 = Icons.visibility;
  IconData icn2 = Icons.visibility;
  final key = GlobalKey<FormState>();

  bool cpi=true;

  void SignUp() async {
    if (key.currentState!.validate()) {
      // await showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );
     
      try {
        if (password.text == confirmPassword.text) {
          UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: mail.text, password: password.text);
            FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).collection('Profile').doc(userCredential.user!.email).set({
            'img':'https://th.bing.com/th?id=OIP.TmFdrhMS6gzhI-ACF3977wHaF2&w=281&h=222&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'
          });

          // if (context.mounted) {
          //   Navigator.pop(context);
          // }
          mail.clear();
          password.clear();
        } else {
          errorMessage('Passwords don\'t match', );
          // Navigator.pop(context);
        }
      } on FirebaseAuthException catch (er) {
        // Navigator.pop(context);
        errorMessage(er.code, );
      }

    }
  }

  void errorMessage(String msg, ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Center(
                child: Text(
              msg,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            )),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w= MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: key,
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
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/appicon.png'),
                            fit: BoxFit.fill)
                    ),
                  ),
                  // SizedBox(height: w*0.04,),
                  const Text('Dear Diary',style: TextStyle(fontSize: 32,fontWeight: FontWeight.w500),),
                  customTextField(
      maxLines: 1,
                      keyboardType: TextInputType.text,

                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Palatte.mainColor2,
                      ),
                      controller: mail,
                      labelText: 'E-Mail',
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
                      Seen: false),
                  customTextField(
                    maxLines: 1,
                      keyboardType: TextInputType.text,

                      suffixIcon: InkWell(
                          onTap: () {
                            isSeen1 = !isSeen1;
                            setState(() {
                              if (isSeen1 == true) {
                                icn1 = Icons.visibility;
                              } else {
                                icn1 = Icons.visibility_off;
                              }
                            });
                          },
                          child: Icon(
                            icn1,
                            color: Palatte.mainColor2,
                          )),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Palatte.mainColor2,
                      ),
                      controller: password,
                      labelText: 'Password',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Password';
                        } else if (val.length < 6) {
                          return 'Please Enter Valid Password';
                        } else {
                          return null;
                        }
                      },
                      color: Palatte.mainColor2,
                      Seen: isSeen1),
                  customTextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Palatte.mainColor2,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            isSeen2 = !isSeen2;
                            setState(() {
                              if (isSeen2 == true) {
                                icn2 = Icons.visibility;
                              } else {
                                icn2 = Icons.visibility_off;
                              }
                            });
                          },
                          child: Icon(
                            icn2,
                            color: Palatte.mainColor2,
                          )),
                      controller: confirmPassword,
                      labelText: 'Confirm Password',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Password';
                        } else if (val.length < 6) {
                          return 'Please Enter Valid Password';
                        } else {
                          return null;
                        }
                      },
                      color: Palatte.mainColor2,
                      Seen: isSeen2),
                  customButton(
                      onPressed: () {
                        SignUp();
                      },
                      color: Palatte.mainColor,
                      child: const Text('Sign up',style: TextStyle(fontSize: 18,color: Palatte.mainColor2),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login',
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
      ),
    );
  }
}
