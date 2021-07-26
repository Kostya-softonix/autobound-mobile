import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl extends StatelessWidget {
  final String title;
  final String url;
  final String urlPlaceholder;

  LaunchUrl(
    this.title,
    this.url,
    this.urlPlaceholder
  );

  @override
  Widget build(BuildContext context) {

    void _launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';


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
            onTap: _launchURL,
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