import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/SearchBar.dart';
import '../widgets/ExpandedCard.dart';
import '../models/trigger.dart';
import '../providers/campaigns.dart';

class TriggerScreen extends StatelessWidget {
  static const routeName = '/trigger-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isLoading = context.watch<Campaigns>().isLoading;

    final Trigger trigger = ModalRoute.of(context).settings.arguments;

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

        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: HexColor('E5E5E5'),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: deviceSize.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
                      child: Text(
                        'Contacts: ${trigger.contacts} / Companies: ${trigger.companies} / Groups: ${trigger.groups}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SearchBar(),
                  ],
                ),
                isLoading
                ? Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.7,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                      strokeWidth: 3,
                    ),
                  ),)
                : Consumer<Campaigns>(
                    builder: (ctx, camp, _) => Container(
                      width: deviceSize.width,
                      height: deviceSize.height * 0.7,
                      margin: EdgeInsets.only(top: 10.0),
                      child: camp.selectedCampaign.groups.length > 0
                      ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                            itemCount: camp.filteredCampaign.groups.length,
                            itemBuilder: (ctx, i) =>
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpandedCard(
                                    camp.filteredCampaign.groups[i],
                                    trigger,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                      : Container(
                        padding: EdgeInsets.only(top: 50),
                        width: double.infinity,
                        child: Text('No contact found.', textAlign: TextAlign.center,)
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