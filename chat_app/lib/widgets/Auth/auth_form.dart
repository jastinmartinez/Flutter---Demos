import 'dart:io';

import '../pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this._submitFn, this.isLoading);
  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext context,
  ) _submitFn;

  final bool isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail;
  String _userName;
  File image;
  String _userPassword;
  var _isLogin = true;
  var _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick an image!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget._submitFn(
        _userEmail.trim(),
        _userName != null ? _userName.trim() : _userName,
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  if (_isLogin)
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: AssetImage('assets/images/varon.png'),
                      radius: 40,
                    ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: ValueKey('Email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    validator: (email) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (email.isEmpty || !emailValid) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (email) {
                      return _userEmail = email;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      autocorrect: true,
                      enableSuggestions: false,
                      key: ValueKey('Username'),
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (username) {
                        if (username.isEmpty || username.length < 4) {
                          return 'Username must be at least 4 characters long';
                        }
                        return null;
                      },
                      onSaved: (username) {
                        return _userName = username;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (password) {
                      if (password.length < 7 || password.isEmpty) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (password) {
                      return _userPassword = password;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Sign up'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'Create New Account?'
                          : 'I Already have an Account'),
                      onPressed: () {
                        setState(
                          () {
                            _isLogin = !_isLogin;
                          },
                        );
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
