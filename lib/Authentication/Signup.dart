import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class signUp extends StatefulWidget {
  final Function()? onTap;

  const signUp({super.key, this.onTap});

  @override
  State<signUp> createState() => _signUpState();
}


class _signUpState extends State<signUp> {
  final mail=TextEditingController();
  final password=TextEditingController();
  final confirmPassword=TextEditingController();

  bool isSeen1=true;
  bool isSeen2=true;
  IconData icn1 = Icons.visibility;
  IconData icn2 = Icons.visibility;
  final key=GlobalKey<FormState>();
  void SignUp()async{
    if(key.currentState!.validate()){
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        if (password.text == confirmPassword.text ) {
         await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: mail.text, password: password.text);


          if (context.mounted) {
            Navigator.pop(context);
          }
          mail.clear();
          password.clear();
        } else {
          errorMessage('Passwords don\'t match');
          Navigator.pop(context);
        }
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
                  style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: h*0.3,),
                customTextField(
                  prefixIcon: Icon(Icons.mail,color: Colors.red,),
                    controller: mail, labelText: 'E-Mail', validator:  (val) {

                  if (val!.isEmpty) {
                    return 'Please Enter Your Email';
                  } else if (!val.endsWith('@gmail.com')) {
                    return 'Please enter a valid Email';
                  } else {
                    return null;
                  }
                }, color: Colors.red, Seen: false),
                customTextField(
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
                        child: Icon(icn1,color: Colors.red,)),
                    prefixIcon: Icon(Icons.password,color: Colors.red,),
                    controller: password, labelText: 'Password', validator: (val){
                  if(val!.isEmpty){
                    return 'Please Enter Password';
                  }else if(val.length<6){
                    return 'Please Enter Valid Password';
                  }else{
                    return null;
                  }
                }, color: Colors.red, Seen: isSeen1),
                customTextField(
                    prefixIcon: Icon(Icons.password,color: Colors.red,),
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
                        child: Icon(icn2,color: Colors.red,)),
                    controller: confirmPassword, labelText: 'Confirm Password', validator: (val){
                  if(val!.isEmpty){
                    return 'Please Enter Password';
                  }else if(val.length<6){
                    return 'Please Enter Valid Password';
                  }else{
                    return null;
                  }
                }, color: Colors.red, Seen: isSeen2),
                customButton(onPressed: SignUp, child: Text('Sign up')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                        onTap: widget.onTap,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
