import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoButton(
          onPressed: () => {
            context.read<Auth>().logOut()
            // Navigator.of(context).pushNamed(AuthScreen.routeName),
          },
          child: Text('Logout'),
          color: CupertinoColors.label,
        ),

      ),
    );
  }
}