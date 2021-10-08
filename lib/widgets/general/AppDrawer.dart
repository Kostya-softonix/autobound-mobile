import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:autobound_mobile/models/auth/auth_models.dart';
import 'package:autobound_mobile/providers/auth.dart';
import 'package:autobound_mobile/core/theme_colors.dart';


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
                color: greyTitle,
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
    final UserProfile userProfile = context.watch<Auth>().userProfile;


    final String firstName = userProfile.firstName ?? 'Unknown';
    final String lastName = userProfile.lastName ?? 'Unknown';
    final String userAchronym = '${firstName.substring(0,1)}${lastName.substring(0,1)}' ?? '?';
    final String company = userProfile.companyName ?? 'Unknown';
    final String jobTitle = userProfile.jobTitle ?? 'Unknown';
    final String email = userProfile.email ?? 'Unknown';
    final String companyWebsiteUrl = userProfile.companyWebsiteUrl ?? 'Unknown';

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
                  profileInfoItem('First Name:', userProfile.firstName),
                  profileInfoItem('Last Name:', userProfile.lastName),
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