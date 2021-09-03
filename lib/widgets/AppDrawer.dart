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
      child: Row(
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
    final Map<String, dynamic> userProfile = context.read<Auth>().userProfile;

    final String userAchronym = userProfile['firstName'][0] + userProfile['lastName'][0].toString();
    final String user = userProfile['firstName'] + userProfile['lastName'].toString();
    final String company = userProfile['companyName'] == null ? 'Unknown' : userProfile['companyName'].toString();
    final String jobTitle = userProfile['jobTitle'] == null ? 'Unknown' : userProfile['jobTitle'].toString();
    final String email = userProfile['email'].toString();
    final String companyWebsiteUrl = userProfile['companyWebsiteUrl'] == null ? 'Unknown' : userProfile['companyWebsiteUrl'].toString();

    return
      Drawer(
        elevation: 10,
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
                        userAchronym,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  profileInfoItem('User:', user),
                  profileInfoItem('Company:', company),
                  profileInfoItem('Job title:', jobTitle),
                  profileInfoItem('Email:', email),
                  profileInfoItem('Website:', companyWebsiteUrl),
                ],
              ),
              SizedBox(
                width: 160,
                height: 40,
                child: CupertinoButton(
                  onPressed: () => {
                    context.read<Auth>().logOut()
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  minSize: kMinInteractiveDimensionCupertino,
                  color: Theme.of(context).primaryColor,
                  child: Text('Logout', style: TextStyle(fontSize: 15),),
                ),
              ),
            ],
          ),
        ),
    );
  }
}