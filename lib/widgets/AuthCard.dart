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
      title: Text('Authentication error!'),
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

  void _onChangeEmail(String value) {
    if(value == '') {
      setState(() {
        _emailErrorMessage = '';
      });
    }
    _authData['email'] = value;
  }

  void _onChangePassword(String value) {
    if(value == '') {
      setState(() {
        _passwordErrorMessage = '';
      });
    }
    _authData['password'] = value;
  }

  bool validateEmail() {
    setState(() {
      _emailErrorMessage = '';
    });

    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(_emailController.text);

    if(_emailController.text.isEmpty) {
      setState(() {
        _emailErrorMessage = 'Email is required';
      });
      return false;
    } else {
      if(emailValid) {
        setState(() {
          _emailErrorMessage = '';
        });
        return true;
      } else {
         setState(() {
          _emailErrorMessage = 'Email is invalid';
        });
        return false;
      }
    }
  }

  bool validatePassword() {
    setState(() {
      _passwordErrorMessage = '';
    });

   final bool passwordValid =_passwordController.text.length > 8;

    if(_passwordController.text.isEmpty) {
      setState(() {
        _passwordErrorMessage = 'Password is required';
      });
      return false;
    } else {
      if(passwordValid) {
        setState(() {
         _passwordErrorMessage = '';
        });
        return true;
      } else {
        setState(() {
          _passwordErrorMessage = 'Password is to short';
        });
        return false;
      }
    }
  }

  Future<void> _submit() async {
    final eValid = validateEmail();
    final pValid = validatePassword();

    if(eValid && pValid) {
      FocusScope.of(context).unfocus();
    }

    if(eValid && pValid) {
      setState(() {
        isLoading = true;
      });
      try {
        final res = await context.read<Auth>().authentication(_authData['email'], _authData['password']);
        print(res);
        if(res != 'success') {
          _showDialog(context, res);
        }
      } catch (error) {
        print(error);
        throw error;
      } finally {
         setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      width: deviceSize.width * 1,
      child: Column(
        children: <Widget>[

          // Header Welcome
          Padding(
            padding: const EdgeInsets.only(top: 90.0, bottom: 14.0),
            child: Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text(
              'Please login with your account.',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
            ),
          ),

          // Form
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: <Widget>[
                CupertinoTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.center,
                  clearButtonMode: OverlayVisibilityMode.editing,

                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1,
                  ),

                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.8,
                      color: _emailErrorMessage.isNotEmpty
                      ? CupertinoColors.systemRed
                      : CupertinoColors.inactiveGray,
                    ),
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                  placeholder: 'Enter your email',
                  placeholderStyle: TextStyle(
                    fontSize: 16,
                    height: 1,
                    color: CupertinoColors.inactiveGray
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: _onChangeEmail,
                ),

                // Email Error
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 5.0,),
                  child: Text(
                    _emailErrorMessage.isNotEmpty ? _emailErrorMessage : '',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: <Widget>[
                // Password input
                CupertinoTextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textAlignVertical: TextAlignVertical.center,

                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1,
                    textBaseline: TextBaseline.alphabetic,
                  ),

                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.8,
                      color: _passwordErrorMessage.isNotEmpty
                      ? CupertinoColors.systemRed
                      : CupertinoColors.inactiveGray,
                    ),
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                  placeholder: 'Enter your password',
                  placeholderStyle: TextStyle(
                    fontSize: 16,
                    height: 1,
                    color: CupertinoColors.inactiveGray
                  ),

                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: _onChangePassword,
                ),

                //Password Error
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _passwordErrorMessage.isNotEmpty ? _passwordErrorMessage : '',
                    style: TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 14.0
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Login Button / Spinner
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 200.0),
            width: isLoading
              ? 38.0
              : double.infinity,
            height: 38.0,
            child: isLoading
              ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor
                ),
                strokeWidth: 2,
              )
              : CupertinoButton(
                onPressed: _submit,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
          ),
        ],
      ),
    );
  }
}
