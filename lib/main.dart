import 'package:dear_diary/Authentication/Login.dart';
import 'package:dear_diary/Authentication/authPage.dart';
import 'package:dear_diary/Notifications/firebaseApi.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/Provider/lockedDataProvider.dart';
import 'package:dear_diary/View/spalashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dear_diary/View/palatte.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  tz.initializeTimeZones();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>firebaseMethods()),
        ChangeNotifierProvider(create: (context)=>lockedData())
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          useMaterial3: false
        ).copyWith(
    scaffoldBackgroundColor: Palatte.white,
    appBarTheme: AppBarTheme(
    backgroundColor: Palatte.white
    ),),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
