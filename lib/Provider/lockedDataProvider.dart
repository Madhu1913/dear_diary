import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../InterFace/previousNotes.dart';
class lockedData extends ChangeNotifier{
  final currentUser = FirebaseAuth.instance.currentUser;
  var dateformatter = DateFormat('dd-MM-yyyy');
  var timeformatter = DateFormat('H:m a');
  var imgtimeformatter = DateFormat('S');
  void addToDB() async {
    if (key.currentState!.validate()) {

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
  void showCalender(context){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050)
    ).then((value){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>previousNotes(date: 'Locked-${dateformatter.format(value!)}')));
    });
    notifyListeners();
  }
}