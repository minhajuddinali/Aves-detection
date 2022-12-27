
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:webapp/screens/image_picker_web.dart';
import 'package:webapp/screens/login_view.dart';
import 'package:webapp/screens/register_view.dart';
import 'package:webapp/screens/verify_email_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Introduction',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home:  HomePage2(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/imagepicker/': (context) => Image_Pick_Web(),
      },
    ),

  );
}
class HomePage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text("Introduction..",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
      ),
      body:Center(
        widthFactor: 1.5,
        child: Column(
          children: <Widget>[
            const Text(
              "Welcome to" ,//"\nBIRDS-CYCLOPEDIA',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10,),
            Text("BIRDS-CYCLOPEDIA",style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color: Colors.white),),
            Text("(Let's capture and learn!)",style: TextStyle(decoration: TextDecoration.underline,
                fontSize: 20,fontStyle: FontStyle.italic,color: Colors.black),),
            Text("This app is developed for easy and fast learning about birds .The app works like google lens i.e, whenever your "
                "capture an image or select image the app will predict the name of the bird with its accuracy in percentage. \n"
                "The app is built using Flutter and the machine learning model which predicts the images in trained using "
                "InceptionV3 and your credentials are secured with us in our database although this is the basic version of "
                "the app --updates arriving soon\n\n Team NGIT",textAlign: TextAlign.left,style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,color: Colors.black54),
            ),
            Text("For queries- contact : supportavesngit@gmail.com",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.black54,fontSize: 15),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: const Icon(Icons.arrow_forward,color: Colors.white,),
        backgroundColor: Colors.black87,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
    throw UnimplementedError();
  }

}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),

      builder: (context, snapshot) {
        switch (snapshot.connectionState) {

          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            // print(user);
            if (user != null) {
              if (user.emailVerified) {
                print('Email is verified');
              } else {
                return const LoginView();
              }
            }
            return const LoginView();

        //return const Text('Done');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
