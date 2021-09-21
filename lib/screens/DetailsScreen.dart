import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../models/trigger.dart';
import '../widgets/ContactCard.dart';
import '../widgets/ActionButtons.dart';
import '../widgets/SignalInfo.dart';
import '../screens/ContactDetailsScreen.dart';
import '../core/helpers.dart';

import '../models/general.dart';
import '../providers/details.dart';


class DetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    final isLoading = context.watch<Details>().isLoading;

    final String insight = context.watch<Details>().insight;
    final bool isInsight = insight == 'insight';

    // print('insight');
    // print(insight);

    final Contact contact = data['contact'];
    final Trigger trigger = data['trigger'];
    final Group group = data['group'];

    final content = context.watch<Details>().content;

    final appBar = generateAppBar(trigger.name);

    void pushToContactDetailsScreen() {
      Navigator.of(context).pushNamed(
        ContactDetailsScreen.routeName,
        arguments: contact,
      );
    }
    // print(trigger.toMap());
    // print(contact.toMap());
    // print(group.toMap());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: appBar,

      body: isLoading
      ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          strokeWidth: 3,
        ),
      )

      : Stack(
        children: [
          Positioned(
            height: calculateHeight(context, appBar, 0.9),
            // height: deviceSize.height * 0.8,
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
                    if(isInsight) Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: SignalInfo(),
                    ),
                    // COntact Card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () => pushToContactDetailsScreen(),
                        child: ContactCard(contact),
                      ),
                    ),
                    // Email content
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 20),
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Card(

                        child: Column(children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: content?.length,
                              itemBuilder: (ctx, i) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                child: Text(content[i]['text'], style: TextStyle(color: Colors.black87, fontSize: 14)),
                              ),
                            ),
                          )
                        ],)

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
            height: calculateHeight(context, appBar, 0.1),
            width: deviceSize.width,
            child: ActionButtons(),
          ),
        ],
      ),
    );
  }
}