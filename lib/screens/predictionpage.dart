import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wikidart/wikidart.dart';
import 'package:url_launcher/url_launcher.dart';
class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key,required this.image}) : super(key: key);
  final XFile image;

  @override
  PredictionPageState createState() => PredictionPageState();
}

class PredictionPageState extends State<PredictionPage> {
late String temp;
  // late File _image;
  late List _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }


  var _desc;
  Future<void> wikiret(String label) async {
    var res = await Wikidart.searchQuery(label);
    var pageid = res?.results?.first.pageId;

    if (pageid != null) {
      var google = await Wikidart.summary(pageid);

      // print(google?.title); // Returns "Google"
      // print(google?.description); // Returns "American technology company"
       //print(google?.extract);
       _desc=google?.extract;// Returns "Google LLC is an American multinational technology company that specializes in Internet-related..."
    }
    else
      {
        print("not found");
      }
  }



  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/CzJLC.tflite",
        labels: "assets/labels_450.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      widget.image;
      imageSelect = true;
    });
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Prediction Page"),
          backgroundColor: Colors.blueGrey,
         // backgroundColor: Colors.blueGrey,
        ),
        body: ListView(
            children: [
            Container(
                margin: const EdgeInsets.all(10),
              child: Image.file(File(widget.image!.path)),
            ),

              SingleChildScrollView(
    child: Column(
    children: (imageSelect)?_results.map((result) {
       temp=result['label'];
      wikiret(temp);
    return Card(

    child: Container(
      color: Colors.black,
    margin: EdgeInsets.all(10),
    child: Text(

    "${result['label']} - with accuracy:${result['confidence']*100}%",
    style: const TextStyle(color: Colors.white,
    fontSize: 20),
    ),
    ),
    );
    }).toList():[],

    ),
    ),


      FloatingActionButton.extended(
        label: Text('predict',style: TextStyle(color: Colors.teal),), // <-- Text
        backgroundColor: Colors.black87,
        hoverColor: Colors.white,
        splashColor: Colors.red,
        icon: Icon( // <-- Icon
          Icons.search,
          size: 35.0,
          color: Colors.teal    ,
        ),
        onPressed: () {
    if(widget.image!=null)
       {
     imageClassification(File(widget.image!.path));

     // Card(
     //
     //   child: Container(
     //     color: Colors.black,
     //     margin: EdgeInsets.all(10),
     //
     //     child: Text(
     //
     //       "About:\n$_desc",
     //       style: const TextStyle(color: Colors.white,
     //           fontSize: 20),),
     //   ),
     //);
       }
        },
      ),
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Text('Description',style: TextStyle(color: Colors.white),);
                },

                //   child:
                // label: Text('Description',style: TextStyle(color: Colors.black87),), // <-- Text
                // backgroundColor: Colors.white,
                // hoverColor: Colors.black87,
                // splashColor: Colors.tealAccent,
                // icon: Icon( // <-- Icon
                //   Icons.search,
                //   size: 35.0,
                //   color: Colors.cyan,
                // ),
                // onPressed: () {},

                 child: Card(

                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(10),

                        child: Text(

                          "About:\n$_desc",
                          style: const TextStyle(color: Colors.black,
                              fontSize: 20),),
                      ),
                    )
    ),
    FloatingActionButton.extended(
    label: Text('Read More..',style: TextStyle(color: Colors.teal),), // <-- Text
    backgroundColor: Colors.black,
    hoverColor: Colors.black87,
    splashColor: Colors.tealAccent,
    icon: Icon( // <-- Icon
    Icons.chrome_reader_mode,
    size: 35.0,
    color: Colors.teal,
    ),
    onPressed: () async{
      String te=temp.toLowerCase();
      String url="https://en.wikipedia.org/wiki/$te";
          if(await canLaunchUrlString(url))
            {
              await launchUrlString(url);
            }
    },),


    //  Card(
    //
    // child: Container(
    // color: Colors.black,
    // margin: EdgeInsets.all(10),
    //
    // child: Text(
    //
    // "About:\n$_desc",
    // style: const TextStyle(color: Colors.white,
    // fontSize: 20),),
    // ),
    // ),
    ],
    )
    );


  }
}