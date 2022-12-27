import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'image_picker_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(children: [
          SizedBox(height: 100,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20,),
            child: TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecoration(
                hintText: 'Enter email or Phone number',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                prefixIcon: Icon(Icons.email_rounded,color: Colors.black,),
                  enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(30),
            ),
            ),

          ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:  InputDecoration(
                prefixIcon: Icon(Icons.lock ,color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.circular(30),
                ),

                hintText: 'Enter password',
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
              ),

            ),
          ),
          SizedBox(height: 20,),
          FloatingActionButton.extended(
            label: Text('Login',style: TextStyle(color: Colors.black87),), // <-- Text
            backgroundColor: Colors.teal,
            hoverColor: Colors.black87,
            splashColor: Colors.black87,
            icon: Icon( // <-- Icon
              Icons.lock_open,
              size: 20.0,
              color: Colors.black87,
            ),
            onPressed: () async {
    BorderRadius.circular(25);
    final email = _email.text;
    final password = _password.text;
    try {
    final UserCredential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
    );
    }
    on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    devtools.log("User not found");
    } else if (e.code == 'wrong-password') {
    devtools.log("Wrong password");
    } else {
    devtools.log("no");
    }
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Image_Picker()));

            },
          ),
          // TextButton(
          //   onPressed: () async {
          //
          //     BorderRadius.circular(25);
          //     final email = _email.text;
          //     final password = _password.text;
          //     try {
          //       final UserCredential =
          //       await FirebaseAuth.instance.signInWithEmailAndPassword(
          //         email: email,
          //         password: password,
          //       );
          //     }
          //     on FirebaseAuthException catch (e) {
          //       if (e.code == 'user-not-found') {
          //         devtools.log("User not found");
          //       } else if (e.code == 'wrong-password') {
          //         devtools.log("Wrong password");
          //       } else {
          //         devtools.log("no");
          //       }
          //     }
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => Image_Picker()));
          //   },
          //   style: TextButton.styleFrom(primary: Colors.teal),
          //   child: const Text('Login'),
          // ),
          TextButton(

              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              style: TextButton.styleFrom(primary: Colors.teal),
              child: const Text('Not registered yet? Register here! '))
        ]));
  }
}
