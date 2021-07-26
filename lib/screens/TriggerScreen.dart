import 'package:flutter/material.dart';
import '../models/trigger.dart';

class TriggerScreen extends StatefulWidget {

  static const routeName = '/trigger-screen';

  @override
  _TriggerScreenState createState() => _TriggerScreenState();
}

class _TriggerScreenState extends State<TriggerScreen> {

  @override
  Widget build(BuildContext context) {
    final Trigger trigger = ModalRoute.of(context).settings.arguments;


    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize);

    return Scaffold(
      appBar:
      AppBar(
        title: Text(
          trigger.name,
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
        padding: const EdgeInsets.all(14.0),
        height: deviceSize.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contacts: ${trigger.contacts} / Companies: ${trigger.companies} / Groups: ${trigger.groups}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }
}