import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

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
    return formatter.format(DateTime.tryParse(date));
  } else {
    return 'Unknown';
  }
}

Future<void> launchURL(String url) async => {
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url'
};

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

SnackBar generateSnackBar (String title, String message) {
  return SnackBar(
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.white,
    duration: Duration(seconds: 3),
    content: SizedBox(
      height: 80,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.green,
                size: 18.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  )
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 6),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black87,
                  fontSize: 14
              )
            )
          ),
        ],
      ),
    ),
  );
}

showDialogCupertino(BuildContext context, String message) {

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Authentication error!'),
      content: Text(message),
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

