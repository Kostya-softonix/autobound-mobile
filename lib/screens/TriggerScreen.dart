import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/ExpandedCard.dart';
import '../models/trigger.dart';
import '../providers/auth.dart';

class TriggerScreen extends StatefulWidget {

  static const routeName = '/trigger-screen';

  @override
  _TriggerScreenState createState() => _TriggerScreenState();
}

class _TriggerScreenState extends State<TriggerScreen> {

  @override
  Widget build(BuildContext context) {
    final Trigger trigger = ModalRoute.of(context).settings.arguments;
    final String id = trigger.id;
    print(id);

    // final auth = context.watch<Auth>().selectedCampaign;
    // final store = Provider.of<Auth>(context);

    final deviceSize = MediaQuery.of(context).size;
    // print(deviceSize);

    setState(() {
      print('Set state');
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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

        body: FutureBuilder(
          future: context.read<Auth>().fetchGroupsByTrigger(id),
          builder: (ctx, resSnapshot) => resSnapshot.connectionState == ConnectionState.waiting
          ? Center(child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              strokeWidth: 3,
            ),)
          : Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            height: deviceSize.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Contacts: ${trigger.contacts} / Companies: ${trigger.companies} / Groups: ${trigger.groups}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),

                Consumer<Auth>(
                  builder: (ctx, authData, _) => authData.selectedCampaign.contacts.isEmpty
                  ? Center(child: Text('No contacts yet.'),)
                  : Container(
                    width: deviceSize.width,
                    height: deviceSize.height * 0.75,
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                          itemCount: authData.selectedCampaign.groups.length,
                          itemBuilder: (ctx, i) =>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpandedCard(authData.selectedCampaign.groups[i]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}