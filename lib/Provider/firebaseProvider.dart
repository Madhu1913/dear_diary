

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/InterFace/previousNotes.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class firebaseMethods extends ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser;
  var dateformatter = DateFormat('dd-MM-yyyy');
  var timeformatter = DateFormat('H:m a');
  var imgtimeformatter = DateFormat('S');
  void addToDB() async {
    if (key.currentState!.validate()) {
      // print(timeformatter.format(date));
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .collection(dateformatter.format(DateTime.now()))
          .add({
        'note': note.text.trim(),
        'Time': timeformatter.format(DateTime.now()),
        'TimeStamp': Timestamp.now(),
        'differentiator': 1
      }).then((value) {
        note.clear();
      });
    }
  }

  final note = TextEditingController();
  final key = GlobalKey<FormState>();

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

    print('DownloadLink:$urlDownload');
    Images = urlDownload;
  }

  void selectImage() async {
    await pickImage();
    await uploadFile();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .collection(dateformatter.format(DateTime.now()))
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
        .collection(dateformatter.format(DateTime.now()))
        .doc(id)
        .delete().then((value){
          print('deleted');
    });
    notifyListeners();
  }
  void showCalender(context){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050)
    ).then((value){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>previousNotes(date: dateformatter.format(value!))));
    });
    notifyListeners();
  }


  String? profilePic;
  File? _selectedProfileImage;
  UploadTask? uploadProfileTask;

  pickProfileImage() async {
    XFile? imgfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imgfile != null) {
      _selectedProfileImage = File(imgfile.path);
      notifyListeners();
    }
  }

  Future uploadProfileFile() async {
    final path =
        'files/${currentUser!.uid}';
    final file = File(_selectedProfileImage!.path);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadProfileTask = ref.putFile(file);
    notifyListeners();
    final snapshot = await uploadProfileTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('DownloadLink:$urlDownload');
    profilePic = urlDownload;
  }

  void selectProfileImage() async {
    await pickProfileImage();
    await uploadProfileFile();
    await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection('Profile').doc(currentUser!.email).update(
        {
          'img':profilePic
        });
    notifyListeners();
  }
  void defaultProfile()async{
    await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection('Profile').doc(currentUser!.email).update({
      'img':'https://th.bing.com/th?id=OIP.TmFdrhMS6gzhI-ACF3977wHaF2&w=281&h=222&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'
    });
    notifyListeners();
  }
  int? i ;
  Future checkLock()async{
    final snapshot=await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).collection('Lock').doc(currentUser!.email).get();
    if(snapshot.exists){
      i=1;
    }else{
      i=0;
    }

    notifyListeners();
  }



}
