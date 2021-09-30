import 'package:flutter/material.dart';

import '../widgets/ContactSale.dart';
import '../widgets/AuthCard.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // Prevent keyboard overflow
      resizeToAvoidBottomInset: false,

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        width: deviceSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset('assets/images/logo.png',
                // fit: BoxFit.contain,
                width: 180.0,
                height: 40.0,
              ),
            ),

            AuthCard(),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ContactSale('Don\'t have an account?', 'Contact Sale.'),
            ),
          ]
        ),
      ),
    );
  }
}

