import 'package:flutter/material.dart';

import '../widgets/ContactSale.dart';
import '../widgets/AuthCard.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height * 0.9,
                width: deviceSize.width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image.asset('assets/images/logo.png', width: 180, height: 63.0,),
                    ),
                    AuthCard(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ContactSale('Don\'t have an account?', 'Contact Sale.'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

