import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) =>
      Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(auth.userProfile['firstName'].toString(), style: TextStyle(color: Colors.black),),


              CupertinoButton(
                onPressed: () => {
                  auth.logOut()
                  // Navigator.of(context).pushNamed(AuthScreen.routeName),
                },
                child: Text('Logout'),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        )
      ),
    );
  }
}