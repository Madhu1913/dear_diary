import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/Provider/firebaseProvider.dart';
import 'package:dear_diary/View/customButton.dart';
import 'package:dear_diary/View/customImageview.dart';
import 'package:dear_diary/View/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final currentUser = FirebaseAuth.instance.currentUser;
  // var dateformatter = DateFormat('dd-MM-yyyy');
  // var timeformatter = DateFormat('H:m a');
  // var imgtimeformatter = DateFormat('S');
  // void addToDB() async {
  //   if (key.currentState!.validate()) {
  //     // print(timeformatter.format(date));
  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(currentUser!.uid)
  //         .collection(dateformatter.format(DateTime.now()))
  //         .add({
  //       'note': note.text.trim(),
  //       'Time': timeformatter.format(DateTime.now()),
  //       'TimeStamp': Timestamp.now(),
  //       'differentiator': 1
  //     }).then((value) {
  //       note.clear();
  //     });
  //   }
  // }
  //
  // final note = TextEditingController();
  // final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Consumer<firebaseMethods>(
        builder: (context,value,child)=> Scaffold(
          appBar: AppBar(
            title: Text('Dear Diary'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser!.uid)
                      .collection(value.dateformatter.format(DateTime.now()))
                      .orderBy('TimeStamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            // reverse: true,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              final data = snapshot.data!.docs;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: data[i]['differentiator'] == 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data[i]['Time']),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: Container(
                                              // width: w*0.7,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(16),
                                                      topLeft:
                                                          Radius.circular(16),
                                                      bottomLeft:
                                                          Radius.circular(16))),
                                              child: Text(
                                                data[i]['note'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          customImageView(
                                                              img: data[i]
                                                                  ['note'])));
                                            },
                                            child: Container(
                                              height: h * 0.25,
                                              width: h * 0.25,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          data[i]['note']),
                                                      fit: BoxFit.cover),
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(32),
                                                      bottomLeft:
                                                          Radius.circular(32),
                                                      bottomRight:
                                                          Radius.circular(32))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(data[i]['Time']),
                                        ],
                                      ),
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Form(
                        key: value.key,
                        child: customTextField(
                            suffixIcon: IconButton(
                              onPressed: value.selectImage,
                              icon: Icon(
                                Icons.image,
                                color: Colors.red,
                              ),
                            ),
                            controller: value.note,
                            labelText: 'Enter here...',
                            validator: (val) =>
                                val!.isEmpty ? 'Please Enter Something' : null,
                            color: Colors.red,
                            Seen: false),
                      ),
                    ),
                    customButton(
                        onPressed: value.addToDB,
                        child: Icon(
                          Icons.done,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  final currentUser = FirebaseAuth.instance.currentUser;

//
  // String? profilePic;
  // File? _selectedImage;
  // UploadTask? uploadTask;
  // String? item;
  // pickImage() async {
  //   XFile? imgfile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (imgfile != null) {
  //     setState(() {
  //       _selectedImage = File(imgfile.path);
  //     });
  //   }
  // }
  //
  // Future uploadFile() async {
  //   final path =
  //       'files/${currentUser!.uid + imgtimeformatter.format(DateTime.now())}';
  //   final file = File(_selectedImage!.path);
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   setState(() {
  //     uploadTask = ref.putFile(file);
  //   });
  //   final snapshot = await uploadTask!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //
  //   print('DownloadLink:$urlDownload');
  //   profilePic = urlDownload;
  // }
  //
  // void selectImage() async {
  //   await pickImage();
  //   await uploadFile();
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(currentUser!.uid)
  //       .collection(dateformatter.format(DateTime.now()))
  //       .add({
  //     'note': profilePic,
  //     'Time': timeformatter.format(DateTime.now()),
  //     'TimeStamp': Timestamp.now(),
  //     'differentiator': 0
  //   });
  // }
}
