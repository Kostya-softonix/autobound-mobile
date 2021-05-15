import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({ Key key, }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _emailErrorMessage = '';
  var _passwordErrorMessage = '';

  _showDialog(BuildContext context, String message) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('An error occurred!'),
      content: Text(message + '. Please check your credentials and try again.' ),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _submit() async {
    setState(() {
      _emailErrorMessage = '';
      _passwordErrorMessage = '';
    });

    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(_emailController.text);
    final bool passwordValid = _passwordController.text.length > 8;

    if(!passwordValid) {
      setState(() {
        _passwordErrorMessage = 'Password is to short';
      });
    }
    if(_emailController.text.isEmpty) {
      setState(() {
        _emailErrorMessage = 'Email is required';
      });
    }
    if(_emailController.text.isEmpty) {
      setState(() {
        _passwordErrorMessage = 'Password is required';
      });
    }
    if(_emailController.text.isNotEmpty) {
      if(emailValid) {
        setState(() {
          _emailErrorMessage = '';
        });
      } else {
         setState(() {
          _emailErrorMessage = 'Email is invalid';
        });
      }

    }

    if(emailValid && passwordValid) {
      setState(() {
        isLoading = true;
      });
      try {
        final res = await context.read<Auth>()
        .authentication(_authData['email'], _authData['password']);
        print(res);
        if(res != 'success') {
          _showDialog(context, res);
        }
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        throw error;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 12.0,
      child: Container(
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey[100],
        ),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            // Header
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Please login with your account.',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
              ),
            ),

            // Email input
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0, left: 2.0),
                    child: Icon(CupertinoIcons.envelope, size: 12,),
                  ),
                  Text(
                    'Email',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
            CupertinoTextField(
              controller: _emailController,
              // clearButtonMode: OverlayVisibilityMode.editing,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              // cursorHeight: 12.0,
              placeholder: 'Enter your email',
              // placeholderStyle: TextStyle(fontSize: 12, color: CupertinoColors.inactiveGray),
              onChanged: (value) {
                setState(() {
                  _authData['email'] = value;
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: _emailErrorMessage.isNotEmpty ? CupertinoColors.systemRed : CupertinoColors.inactiveGray,
                ),
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              // style: TextStyle(
              //   fontSize: 14,
              // ),
            ),

            // Email Error
            Container(
              width: double.infinity,
              height: 10.0,
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                _emailErrorMessage.isNotEmpty ? _emailErrorMessage : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10.0,
                ),
              ),
            ),

            // Password input
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 7.0, bottom: 5.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0, left: 2.0),
                    child: Icon(CupertinoIcons.lock, size: 12,),
                  ),
                  Text(
                    'Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
            CupertinoTextField(
              controller: _passwordController,
              obscureText: true,
              // cursorHeight: 12.0,
              placeholder: 'Enter your password',
              // placeholderStyle: TextStyle(fontSize: 12, color: CupertinoColors.inactiveGray),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                setState(() {
                  _authData['password'] = value;
                });
              },
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: _passwordErrorMessage.isNotEmpty ? CupertinoColors.systemRed : CupertinoColors.inactiveGray,
                ),
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              // style: TextStyle(
              //   fontSize: 14,
              // ),
            ),
            //Password Error
            Container(
              width: double.infinity,
              height: 10.0,
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(_passwordErrorMessage.isNotEmpty ? _passwordErrorMessage : '', style: TextStyle(color: CupertinoColors.systemRed, fontSize: 10.0)),
            ),

            // Login Button
            Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
              height: 30.0,
              width: isLoading ? 30.0 : 150.0,
              child: isLoading
              ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), strokeWidth: 2,)
              : ElevatedButton(
                  child: Text('Login', style: TextStyle(fontSize: 14)),
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: Theme.of(context).primaryColor),
                  ),
            ),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 10.0),
                ),
                SizedBox(width: 6.0,),
                Text(
                  'Contact Sale',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
