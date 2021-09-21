import 'dart:core';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSale extends StatelessWidget {
  final String title;
  final String urlPlaceholder;

  ContactSale(
    this.title,
    this.urlPlaceholder
  );

  @override
  Widget build(BuildContext context) {

    void launchMailto() async {
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'sales@autobound.ai',
        queryParameters: {
          'subject': 'Subscribe',
          'body': ''
        }
      );

      String url = params.toString();
      await launch(url);
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
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
            onTap: launchMailto,
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