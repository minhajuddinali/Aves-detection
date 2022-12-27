import 'package:flutter/material.dart';


import '../models/File_Dart_Model.dart';

class DroppedFileWidget extends StatelessWidget {
  // here we get the uploaded file data
  final File_Data_Model? file;
  const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: buildImage(context)),
      ],
    );
  }

  // a custom widget to show image
  Widget buildImage(BuildContext context) {
    // will show no file selected when app is open for first time.
    if (file == null) return buildEmptyFile('No Selected File');

    return Column(
      children: [
        if (file != null) buildFileDetail(file),
        // if file dropped is Image then display image from data model URL variable
        Image.network(
          file!.url,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          // if displaying image failed, that means there is not preview so display no preview
          errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
        ),
      ],
    );
  }

  //custom widget to show no file selected yet
  Widget buildEmptyFile(String text) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.blue.shade300,
      child: Center(child: Text(text)),
    );
  }

  //a custom widget to show uploaded file details to user

  Widget buildFileDetail(File_Data_Model? file) {
    final style = TextStyle(fontSize: 20);
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Selected File Preview ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Text(
            'Name: ${file?.name}',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Type: ${file?.mime}', style: style),
          const SizedBox(
            height: 10,
          ),
          Text('Size: ${file?.size}', style: style),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
