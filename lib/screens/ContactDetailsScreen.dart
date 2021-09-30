import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/details.dart';
import '../core/helpers.dart';
import '../models/general.dart';

class ContactDetailsScreen extends StatelessWidget {
  static const routeName = '/contact-details-screen';

  void _launchURL(String url) async => {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url'
  };

  void redirectOrOpenMailApp(String url, bool isRedirect, bool isEmailRedirect) {
    if(isRedirect) {
      _launchURL(url);
    }
    if(isEmailRedirect) {
      launchMailto(url, '', '');
    }
  }

  Widget profileInfoItem(
    String title,
    String data,
    bool isRedirect,
    bool isEmailRedirect,
    BuildContext context
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
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
            flex: 7,
            child: Container(
              width: double.infinity,
              child:
              GestureDetector(
                onTap: () => redirectOrOpenMailApp(data, isRedirect, isEmailRedirect),
                child: Tooltip(
                  verticalOffset: -70,
                  message: data ?? 'Unknown',
                  showDuration: Duration(milliseconds: 1),
                  child: Text(
                    data ?? 'Unknown',
                    // data == null ? 'Unknown' : data,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: isRedirect || isEmailRedirect
                        ? Theme.of(context).primaryColor
                        : HexColor('262631'),
                      decoration: isRedirect || isEmailRedirect
                        ? TextDecoration.underline
                        : TextDecoration.none,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
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
    final SuggestedGroupCampaingnContact contactDetails = context.watch<Details>().suggestedGroupContact;
    final SuggestedGroupCampaingnCompany companyDetails = context.watch<Details>().suggestedGroupCompany;

    return Scaffold(
      backgroundColor: HexColor('E5E5E5'),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              contactDetails.fullName,
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
                width: 28,
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
              profileInfoItem('Job title:', contactDetails.title, false, false, context),
              profileInfoItem('Company:', companyDetails.name, false, false,context),
              profileInfoItem('Website:', companyDetails.websiteUrl, true, false, context),
              profileInfoItem('Email:', contactDetails.email, false, true, context),
              profileInfoItem('Industry:', companyDetails.industry, false, false, context),
              profileInfoItem('Created date:', contactDetails.externalCreatedAt, false, false, context),
              profileInfoItem('Last activity:', contactDetails.lastActivityAt, false, false, context),
              profileInfoItem('Last campaign date:', contactDetails.lastCampaignStartedAt, false, false, context),
            ],
          )
        ),
      ),
    );
  }
}