import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoButton(
              onPressed: () => {
                context.read<Auth>().logOut()
                // Navigator.of(context).pushNamed(AuthScreen.routeName),
              },
              child: Text('Logout'),
              color: CupertinoColors.label,
            ),
          ],
        ),
      )
    );
  }
}