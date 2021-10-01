import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../../core/html_helpers.dart';
import '../../models/general.dart';

class EditInMailAppButton extends StatelessWidget {
  final String contactEmail;
  final List<CustomEmailContent> content;
  final Map<String, dynamic> customFields;

  EditInMailAppButton(
    this.contactEmail,
    this.content,
    this.customFields
  );

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

  Future<void> openMailClientAndPopulateEmailData(BuildContext context) async {
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
                contactEmail,
              ],
              subject: removeHtmlTags(convertRawHtmlToCustomField(content[0].text, customFields)),
              body: '''
                ${removeHtmlTags(convertRawHtmlToCustomField(content[1].text, customFields))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[2].text, customFields))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[3].text, customFields))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[4].text, customFields))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[5].text, customFields))}
              ''',
              // cc: ['sales@autobound.ai'],
              // bcc: ['sales@autobound.ai'],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      minSize: kMinInteractiveDimensionCupertino,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            CupertinoIcons.envelope_open,
            color: Colors.red,
            size: 18.0,
          ),
          Text(
            'Edit in mail App',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ]
      ),
      color: Colors.white,
      onPressed: () async {
        openMailClientAndPopulateEmailData(context);
      }
    );
  }
}