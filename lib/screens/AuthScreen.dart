import 'package:flutter/material.dart';

import '../widgets/LaunchUrl.dart';
import '../widgets/AuthCard.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final _url = 'https://mail.google.com/mail/u/0/?fs=1&tf=cm&source=mailto&to=sales@autobound.ai';

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset('assets/images/logo.png', width: 180, height: 36.0,),
                  ),

                  AuthCard(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: LaunchUrl('Don\'t have an account?',  _url, 'Contact Sale.'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

