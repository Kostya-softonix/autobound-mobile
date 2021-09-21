import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const apiUrl = 'https://dev.autobound.ai/api/';

AppBar generateAppBar (String title) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}

double calculateHeight (
  BuildContext context,
  AppBar appbar,
  double heightPercent
) {
  return (
      MediaQuery.of(context).size.height
      - appbar.preferredSize.height
      - MediaQuery.of(context).padding.top
  ) * heightPercent;
}

 String formatedDate (String date) {
  //  final DateFormat formatter = DateFormat('HH:mm EEE MMM dd yyyy');
  final DateFormat formatter = DateFormat('EEE MMM dd yyyy');

  if(date != null) {
    return formatter.format(DateTime.parse(date));
  } else {
    return 'Unknown';
  }
}

Future<dynamic> launchMailto(String path, String subject, String body) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: path,
    queryParameters: {
      'subject': subject,
      'body': body
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

String capitalizeFirstLetter (String text) {
  return '${text[0].toUpperCase()}${text.substring(1)}';
}
