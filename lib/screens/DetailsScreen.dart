import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/trigger.dart';
import '../widgets/ContactCard.dart';
import '../providers/campaigns.dart';
import '../widgets/ActionButtons.dart';
import '../widgets/SignalInfo.dart';
import '../screens/ContactDetailsScreen.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;

    final Contact contact = data['contact'];
    final Trigger trigger = data['trigger'];

    void pushToContactDetailsScreen() {
      Navigator.of(context).pushNamed(
        ContactDetailsScreen.routeName,
        arguments: contact,
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          title: Text(
            trigger.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              height: deviceSize.height * 0.8,
              top: 0,
              child: Container(
                width: deviceSize.width,
                decoration: BoxDecoration(
                  color: HexColor('E5E5E5'),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Signal info expanded card
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: SignalInfo(),
                      ),
                      // COntact Card
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: () => pushToContactDetailsScreen(),
                          child: ContactCard(contact),
                        ),
                      ),
                      // Email content
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 40),
                        height: 600,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Card(
                        child: Center(
                            child: Text('Mail content'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Approve / Reject Buttons
            Positioned(
              bottom: 0,
              height: deviceSize.height * 0.1,
              width: deviceSize.width,
              child: ActionButtons(),
            ),
          ],
        ),
      ),
    );
  }
}