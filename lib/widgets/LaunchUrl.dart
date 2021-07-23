import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl extends StatelessWidget {
  final String url;

  LaunchUrl(this.url);


  @override
  Widget build(BuildContext context) {

    void _launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';


    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account?',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 6.0,),
          GestureDetector(
            onTap: _launchURL,
            child: Text(
              'Contact Sale',
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