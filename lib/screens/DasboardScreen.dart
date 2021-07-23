import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/TriggerCard.dart';

// import '../providers/auth.dart';
import '../providers/triggers.dart';


class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final triggers = context.watch<Triggers>().triggers;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suggested campaigns',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,

      ),

      // Center(
      //   child: CupertinoButton(
      //     onPressed: () => {
      //       context.read<Auth>().logOut()
      //       // Navigator.of(context).pushNamed(AuthScreen.routeName),
      //     },
      //     child: Text('Logout'),
      //     color: CupertinoColors.label,
      //   ),

      // ),
      body: Container(
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6),
        width: deviceSize.width,
        height: deviceSize.height,
        padding: EdgeInsets.only(
          left: 14,
          right: 14,
          top: 14,
          bottom: 52
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: triggers.length,
                itemBuilder: (ctx, i) => TriggerCard(triggers[i])
              ),
            ),
          ],
        ),
      ),
    );
  }
}