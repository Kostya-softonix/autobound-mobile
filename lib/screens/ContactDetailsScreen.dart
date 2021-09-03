import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../providers/campaigns.dart';


class ContactDetailsScreen extends StatelessWidget {
  static const routeName = '/contact-details-screen';

  Widget profileInfoItem(String title, String data) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                color: HexColor('2A3256'),
                fontSize: 14.0,
                fontWeight: FontWeight.normal
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Text(
                data == null ? 'Unknown' : data,
                textAlign: TextAlign.end,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: HexColor('262631'),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Contact contact = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                contact.fullName,
                style: TextStyle(
                  color: HexColor('2A3256'),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 1.1
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  'assets/images/sf-logo.png',
                  width: 24,
                  height: 18,
                ),
              ),
            ],
          ),

          backgroundColor: Theme.of(context).primaryColorLight,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),

            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              border: Border.all(
                color: HexColor('B7BED8'),
                width: 1.2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            width: double.infinity,
            child: Column(
              children: [
                profileInfoItem('Job title:', contact.title),
                profileInfoItem('Company:', contact.company),
                profileInfoItem('Website:', 'Unknown'),
                profileInfoItem('Email:', 'Unknown'),
                profileInfoItem('Industry:', 'Unknown'),
                profileInfoItem('Created date:', 'Unknown'),
                profileInfoItem('Last activity:', contact.lastActivityAt),
                profileInfoItem('Last campaign date:', contact.lastCampaignStartedAt),
              ],
            )
          ),
        ),
      ),
    );
  }
}