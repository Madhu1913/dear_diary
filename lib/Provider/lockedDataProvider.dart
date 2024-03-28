import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/View/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Locked/lockedPreviousNotes.dart';
class lockedData extends ChangeNotifier{
  final currentUser = FirebaseAuth.instance.currentUser;
  var dateformatter = DateFormat('dd-MM-yyyy');
  var timeformatter = DateFormat('H:m a');
  var imgtimeformatter = DateFormat('S');
  void addToDB() async {
if(note.text.trim()!=''){

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(currentUser!.uid)
      .collection('Locked-${dateformatter.format(DateTime.now())}')
      .add({
    'note': note.text.trim(),
    'Time': timeformatter.format(DateTime.now()),
    'TimeStamp': Timestamp.now(),
    'differentiator': 1
  }).then((value) {
    note.clear();
  });
}else{
  Get.snackbar('Note : ', 'Please Enter Something',snackPosition: SnackPosition.BOTTOM,colorText:Palatte.white,backgroundColor: Palatte.buttonColor, );
}

  }

  final note = TextEditingController();

  String? Images;
  File? _selectedImage;
  UploadTask? uploadTask;
  String? item;
  pickImage() async {
    XFile? imgfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imgfile != null) {
      _selectedImage = File(imgfile.path);
      notifyListeners();
    }
  }

  Future uploadFile() async {
    final path =
        'files/${currentUser!.uid + imgtimeformatter.format(DateTime.now())}';
    final file = File(_selectedImage!.path);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);
    notifyListeners();
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    Images = urlDownload;
  }

  void selectImage() async {
    await pickImage();
    await uploadFile();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('Locked-${dateformatter.format(DateTime.now())}')
        .add({
      'note': Images,
      'Time': timeformatter.format(DateTime.now()),
      'TimeStamp': Timestamp.now(),
      'differentiator': 0
    });
    notifyListeners();
  }

  void deleteItem(id) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('Locked-${dateformatter.format(DateTime.now())}')
        .doc(id)
        .delete().then((value){
      print('deleted');
    });
    notifyListeners();
  }
  void showCalender(context)async {
    DateTime? picked=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if(picked!=null){

      await Get.to(()=>lockedPreviousNotes(date: 'Locked-${dateformatter.format(picked)}'));
    }
    notifyListeners();
  }

  void sendPushMessage(String token,String body,String title)async{
    try{
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String,String>{
          'Content-Type':'application/json',
          'Authorization':'key=AAAAVJV8HNo:APA91bFJJmMDCKOGP7FV_ZHB_zqHprtB7UeVRaIdyq1PqsenDH6ZP1FA6nGqEhrV2eDAcOKMcVEknbmT9CCPS7gO2bG2PguqmFWRKT-m-syFYwjDJjyc7OG0EKSwDzNLJSo9e3EcoXRk'
        },
        body: jsonEncode(
          <String,dynamic>{
            'priority':'high',
            'data':<String,dynamic>{
              'click-action':'FLUTTER_NOTIFICATION_CLICK',
              'status':'done',
              'body':body,
              'title':title,
            },
            "notification":<String,dynamic>{
              'title':title,
              'body':body,
              'android_channel_id':'dbfood'
            },
            "to":token,
          }
        )
      );
    }catch(e){
      if(kDebugMode){
        print('Error-push-notification');
      }
    }
    notifyListeners();
  }
 var myformatter=DateFormat('dd-mm-yyyy,H:mm a');
  var now;
  void addTaskTodb(String data,DateTime value)async{
     now=myformatter.format(DateTime.now());
    await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection('Reminders').add(
        {
          'Task':data,
          'time':value,
          'Time':myformatter.format(value),
          'TimeStamp':Timestamp.now(),


        });
    notifyListeners();
  }

}