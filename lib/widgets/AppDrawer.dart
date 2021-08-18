import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {

  Widget profileInfoItem(String title, String data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5.0 ),
      margin: const EdgeInsets.only(top: 10.0),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                color: HexColor('2A3256'),
                fontSize: 11.0,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
          Container(
            width: 170,
            child: Text(
              data,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );



  }



  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        auth.userProfile['firstName'][0] + auth.userProfile['lastName'][0],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  profileInfoItem('User:','${auth.userProfile['firstName']} ${auth.userProfile['lastName']}'),
                  profileInfoItem('Company:', auth.userProfile['companyName'].toString()),
                  profileInfoItem('Job title:', auth.userProfile['jobTitle'].toString()),
                  profileInfoItem('Role:', auth.userProfile['role']['name'].toString()),
                  profileInfoItem('Email:', auth.userProfile['email'].toString()),
                  profileInfoItem('Website:', auth.userProfile['companyWebsiteUrl'].toString()),
                ],
              ),



              SizedBox(
                width: 200,
                height: 50,
                child: CupertinoButton(
                  onPressed: () => {
                    auth.logOut()
                    // Navigator.of(context).pushNamed(AuthScreen.routeName),
                  },
                  child: Text('Logout', style: TextStyle(fontSize: 14),),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}