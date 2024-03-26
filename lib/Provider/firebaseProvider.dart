

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
class firebaseMethods extends ChangeNotifier{
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



  String? profilePic;
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
    profilePic = urlDownload;
  }

  void selectImage() async {
    await pickImage();
    await uploadFile();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .collection(dateformatter.format(DateTime.now()))
        .add({
      'note': profilePic,
      'Time': timeformatter.format(DateTime.now()),
      'TimeStamp': Timestamp.now(),
      'differentiator': 0
    });
    notifyListeners();
  }


}