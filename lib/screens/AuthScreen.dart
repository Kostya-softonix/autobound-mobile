import 'package:flutter/material.dart';

import '../widgets/AuthCard.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevent keyboard overflow
      resizeToAvoidBottomInset: false,
      body: AuthCard(),
    );
  }
}

