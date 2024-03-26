
import 'package:dear_diary/Authentication/Login.dart';
import 'package:dear_diary/Authentication/Signup.dart';
import 'package:dear_diary/InterFace/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return const HomePage();
              }
              else{
                return const _LoginOrRegister();
              }
            }
        )

    );
  }
}


class _LoginOrRegister extends StatefulWidget {
  const _LoginOrRegister();

  @override
  State<_LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<_LoginOrRegister> {
  bool showLoginPage=true;
  void togglePage(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return login(onTap: togglePage);
    }else{
      return signUp(
        onTap: togglePage,
      );
    }
  }
}

