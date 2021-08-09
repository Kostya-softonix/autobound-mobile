import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> contact = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            contact['fullName'],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          child: Center(child: Text(contact['fullName'])),
        ),
      ),
    );
  }
}