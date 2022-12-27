

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import '../models/File_Dart_Model.dart';
import 'drop_zone_view.dart';
import 'dropped_file_view.dart';

class Image_Pick_Web extends StatefulWidget {
  @override
  _Image_Pick_WebState createState() => _Image_Pick_WebState();

}

class _Image_Pick_WebState extends State<Image_Pick_Web> {
  //object of datamodel class
  File_Data_Model? file;
  // Future upload() async{
  //   final path='filess/${file!.name}';
  //   final files=File(file!.path!);
  //   final ref=FirebaseStorage.instance.ref().child(path);
  //   ref.putFile(files);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aves Detector"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                // here DropZoneWidget is statefull widget file
                Container(
                  height: 300,
                  child: DropZone(
                    onDroppedFile: (file) => setState(() => this.file = file),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // DroppedFileWidget is self designed stateless widget to displayed user dropped image file as preview with detail info
                DroppedFileWidget(file: file),
              ],
            )),

      ),



    );
  }
}
