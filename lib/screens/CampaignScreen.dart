import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/TriggerScreen.dart';
import '../providers/triggers.dart';
import '../providers/campaigns.dart';
import '../providers/auth.dart';
import '../widgets/AppDrawer.dart';
import '../widgets/TriggerCard.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({ Key key, }) : super(key: key);

  static const routeName = '/campaigns-screen';

  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  bool _isLoading = false;

  void fetchTriggers () {
     setState(() {
      _isLoading = true;
    });

    final token = context.read<Auth>().token;

    Provider.of<Triggers>(context, listen: false).fetchTriggers(token).then((_) => {
      setState(() {
        _isLoading = false;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTriggers();
  }

  Future<void> _pullTriggersRefresh (BuildContext context) async {
    fetchTriggers();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final token = context.read<Auth>().token;

    final triggers = context.watch<Triggers>().triggers;

    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Suggested campaigns',
            // tok,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          elevation: 1,
        ),
        drawer: AppDrawer(),

        body: _isLoading
        ? Center(child:
          CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            strokeWidth: 3,
          ),
        )
        : RefreshIndicator(
          color: Theme.of(context).primaryColor,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () => _pullTriggersRefresh(context),
          child: triggers.length > 0
          ?
          Container(
            decoration: BoxDecoration(
              color: HexColor('E5E5E5'),
            ),
            width: deviceSize.width,
            height: deviceSize.height,
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
              top: 14.0,
              bottom: 30.0
            ),
            child: Column(
              children: [
                Consumer<Triggers>(
                  builder: (ctx, triggers, _) => Expanded(
                    child: ListView.builder(
                      itemCount: triggers.triggers.length,
                      itemBuilder: (ctx, i) =>
                      GestureDetector(
                        onTap: () => {
                          Provider.of<Campaigns>(context, listen: false).fetchGroupsByTrigger(triggers.triggers[i].id, token),
                          Navigator.of(context).pushNamed(
                          TriggerScreen.routeName,
                          arguments: triggers.triggers[i]),
                        },
                        child: TriggerCard(triggers.triggers[i]),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          )
          : Container(
            margin: EdgeInsets.only(top: 30),
            width: deviceSize.width,
            height: deviceSize.height,
            child: Text(
              'No campaigns available. Please try again later.',
              textAlign: TextAlign.center,
              ),
            ),
        ),
      ),
    );
  }
}