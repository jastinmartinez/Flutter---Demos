import 'dart:io';

import 'package:flutter/services.dart';

import '../widgets/Auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _loadingChangeState(bool val) {
    setState(() {
      _isLoading = val;
    });
  }

  void _submitAuthForm(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext context,
  ) async {
    AuthResult authResult;
    try {
      if (isLogin) {
        _loadingChangeState(true);
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _loadingChangeState(true);
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //unpload image
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;

        // get link to save new register
        final urlUserImage = await ref.getDownloadURL();

        //users collection can be whatever is a name
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(
          {
            'username': username,
            'email': email,
            'userimage': urlUserImage,
          },
        );
      }
    } on PlatformException catch (error) {
      var message = 'An erro ocurred, please check credentials';
      if (error.message != null) {
        message = error.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(message),
        ),
      );
      _loadingChangeState(false);
    } catch (error) {
      print(error);
      _loadingChangeState(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
