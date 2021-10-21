import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:autobound_mobile/models/auth/auth_models.dart';
import 'package:autobound_mobile/core/regexes.dart';
import 'package:autobound_mobile/providers/auth.dart';
import 'package:autobound_mobile/helpers/helpers.dart';


class AuthCard extends StatefulWidget {
  const AuthCard({ Key key, }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthData _authData = AuthData(
    email: '',
    password: '',
  );

  bool isLoading = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _emailErrorMessage = '';
  String _passwordErrorMessage = '';

  void _onChangeEmail(String value) {
    if(value == '') {
      setState(() {
        _emailErrorMessage = '';
      });
    }
    _authData.email = value;
  }

  void _onChangePassword(String value) {
    if(value == '') {
      setState(() {
        _passwordErrorMessage = '';
      });
    }
    _authData.password = value;
  }

  bool validateEmail() {
    setState(() {
      _emailErrorMessage = '';
    });

    final bool emailValid = emailValidation.hasMatch(_emailController.text);

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
        final res = await context.read<Auth>().authentication(_authData);
        print(res);
        if(res != 'success') {
          showDialogCupertino(
            context,
            res + '. Please check your credentials and try again.');
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
    BoxDecoration inputDecoration = BoxDecoration(
      border: Border.all(
        width: 0.8,
        color: _passwordErrorMessage.isNotEmpty
        ? CupertinoColors.systemRed
        : CupertinoColors.inactiveGray,
      ),
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(5.0),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Welcome
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
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
                  focusNode: _emailFocusNode,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1,
                  ),

                  decoration: inputDecoration,
                  textInputAction: TextInputAction.next,

                  placeholder: 'Enter your email',
                  placeholderStyle: const TextStyle(
                    fontSize: 16,
                    height: 1,
                    color: CupertinoColors.inactiveGray
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
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

                  decoration: inputDecoration,

                  placeholder: 'Enter your password',
                  placeholderStyle: TextStyle(
                    fontSize: 16,
                    height: 1,
                    color: CupertinoColors.inactiveGray
                  ),
                  focusNode: _passwordFocusNode,
                  onEditingComplete: _submit,
                  // onEditingComplete: () {
                  //   FocusScope.of(context).unfocus();
                  // },
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
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: isLoading
              ? 38.0
              : double.infinity,
            height: 38.0,
            child: isLoading
              ? CupertinoActivityIndicator(
                animating: true,
                radius: 16,
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
