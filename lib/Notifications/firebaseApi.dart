

import 'dart:async';
import 'dart:convert';

import 'package:dear_diary/InterFace/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;



class FirebaseApi{
  final messaging=FirebaseMessaging.instance;
  final androidChannel=const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance
  );
  final flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();





  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    print('Title :${message.notification?.title}');
  }
  void handleMessage(RemoteMessage? message){
    if(message==null) {return; }
    else{
      Get.to(()=>const HomePage());
    }

  }
  void handleFirebaseMessage(RemoteMessage? message){
    if(message==null) {return; }
    else{
      Get.to(()=>const HomePage());
    }

  }
   Future scheduleNotification(
  {
    int? id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime})async{
    return flutterLocalNotificationsPlugin.zonedSchedule(
        id!,
        title,
        body,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        NotificationDetails(
            android: AndroidNotificationDetails(
                androidChannel.id,
                androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@drawable/appicon'
            )
        ),
        payload: jsonEncode({
          'id':id,
          'title':title,
          'body':body
        }),
        // androidAllowWhileIdle: true,
        // androidScheduleMode: ,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

   }
//   Future showNotification({
//     int id=0,String? title,String? body,String? payload,
// })async{
//     return flutterLocalNotificationsPlugin.show(id, title, body, NotificationDetails(
//         android: AndroidNotificationDetails(
//             androidChannel.id,
//             androidChannel.name,
//             channelDescription: androidChannel.description,
//             icon: '@mipmap/ic_launcher'
//         )
//     ),);
//   }
  Future initPushNotifications()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleFirebaseMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleFirebaseMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification=event.notification;
      if(notification==null){
        return;
      }else{
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                androidChannel.id,
                androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@drawable/appicon'
              )
            ),
          payload: jsonEncode(event.toMap())
        );
      }
    });
  }


  Future initLocalNotifications()async{
    const android=AndroidInitializationSettings('@drawable/appicon');
    const settings=InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(settings,
      onDidReceiveNotificationResponse: (details){
      final message=RemoteMessage.fromMap(jsonDecode(details.payload!));
      if(message.notification?.title=='Dear Diary'){
        handleFirebaseMessage(message);
      }
      handleMessage(message);
      }
    );
    final platform=flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }
 final permission=AndroidFlutterLocalNotificationsPlugin();
  Future<void> initNotification()async{
    final currentUser=FirebaseAuth.instance.currentUser;
    await messaging.requestPermission();
    final token=await messaging.getToken();
    await permission.requestExactAlarmsPermission();
    print('token: $token');
    initPushNotifications();
    initLocalNotifications();
  }
}