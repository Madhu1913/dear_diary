

import 'dart:convert';

import 'package:dear_diary/InterFace/navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


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
      Get.to(()=>navigatorr(data: message.notification?.body));
    }

  }

  Future initPushNotifications()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
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
                icon: '@mipmap/ic_launcher'
              )
            ),
          payload: jsonEncode(event.toMap())
        );
      }
    });
  }
  Future initLocalNotifications()async{
    const android=AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings=InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(settings,
      onDidReceiveNotificationResponse: (details){
      final message=RemoteMessage.fromMap(jsonDecode(details.payload!));
      handleMessage(message);
      }
    );
    final platform=flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }
  Future<void> initNotification()async{
    await messaging.requestPermission();
    final token=await messaging.getToken();
    print('token: $token');
    initPushNotifications();
    initLocalNotifications();
  }
}