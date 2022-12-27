import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webapp/screens/predictionpage.dart';

class Image_Picker extends StatefulWidget {
  const Image_Picker({Key? key /*, required this.title*/}) : super(key: key);

  //final String title;

  @override
  State<Image_Picker> createState() => _Image_PickerState();
}

class _Image_PickerState extends State<Image_Picker> {
  File? image;
  //late XFile file2;
  Future pickImage() async {
    try {
     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
     //XFile file = new XFile(image!.path);
    // file2=file;
      if (image == null) return;

      final XFile imageTemp = XFile(image.path);

     // setState(() => this.image = imageTemp);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => PredictionPage(image: (imageTemp))));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }

  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      //XFile file = new XFile(image!.path);
      if (image == null) return;

      final XFile imageTemp = XFile(image.path);

     // setState(() => this.image = imageTemp);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PredictionPage(image: (imageTemp))));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Image"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(

          child: Column(
            children: [
              SizedBox(height: 150,),
              FloatingActionButton.extended(
                label: Text('Camera',style:TextStyle(color: Colors.black87),), // <-- Text
                backgroundColor: Colors.white,
                hoverColor: Colors.black87,
                splashColor: Colors.black87,
                icon: Icon( // <-- Icon
                  Icons.camera,
                  size: 24.0,
                  color: Colors.cyan,
                ),
                onPressed: () {
                  pickImageC();
                },
              ),
              SizedBox(height: 30,),
              FloatingActionButton.extended(
                label: Text('Files',style: TextStyle(color: Colors.black87),), // <-- Text
                backgroundColor: Colors.white,
                hoverColor: Colors.black87,
                splashColor: Colors.tealAccent,
                icon: Icon( // <-- Icon
                  Icons.image,
                  size: 26.0,
                  color: Colors.cyan,
                ),
                onPressed: () {
                  pickImage();
                },
              ),
              // MaterialButton(
              //     color: Colors.brown,
              //   child: const Text("predict"),
              //     onPressed: (){Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => PredictionPage(image: (file2))));}),
              SizedBox(
                height: 20,
              ),
              image != null
                  ? Image.file(image!)
                  : Text("Please select an image")
            ],
          ),
        ));
  }
}
