import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../models/general.dart';
import '../core/regexes.dart';

class EditInMailAppButton extends StatelessWidget {
  final String contactEmail;
  final List<CustomEmailContent> content;
  final Function convertRawHtmlToCustomField;

  EditInMailAppButton(
    this.contactEmail,
    this.content,
    this.convertRawHtmlToCustomField
  );

  void showNoMailAppsDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Open Mail App"),
            content: Text("No mail apps installed"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }

  String removeHtmlTags(String contentItem) {
    final extendedItem = contentItem.replaceAll(addNewLineRegex, '</p>\n');
    return extendedItem.replaceAll(removeHtmlRegex, '');
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
              subject: removeHtmlTags(convertRawHtmlToCustomField(content[0].text)),
              body: '''
                ${removeHtmlTags(convertRawHtmlToCustomField(content[1].text))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[2].text))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[3].text))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[4].text))}
                ${removeHtmlTags(convertRawHtmlToCustomField(content[5].text))}
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