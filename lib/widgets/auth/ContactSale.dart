import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ContactSale extends StatelessWidget {
  final String title;
  final String urlPlaceholder;

  ContactSale(
    this.title,
    this.urlPlaceholder
  );

  @override
  Widget build(BuildContext context) {

    showNoMailAppsDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Open Mail App'),
      content: Text('No mail apps installed'),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

    Future<void> openMailClientAndPopulateEmailData() async {
      var apps = await OpenMailApp.getMailApps();
      if (apps.isEmpty) {
        showNoMailAppsDialog(context);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return MailAppPickerDialog(
              mailApps: apps,
              emailContent: EmailContent(
                to: [
                  'sales@autobound.ai',
                ],
                subject: 'Subscribe',
                body: 'I would like to use your App!',
                // cc: ['sales@autobound.ai'],
                // bcc: ['sales@autobound.ai'],
              ),
            );
          },
        );
      }
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 6.0,),
          GestureDetector(
            onTap: openMailClientAndPopulateEmailData,
            child: Text(
              urlPlaceholder,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}