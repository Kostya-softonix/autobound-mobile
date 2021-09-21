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
import '../core/helpers.dart';

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

  Future<void> _pullTriggersRefresh (BuildContext context) async {
    fetchTriggers();
  }

  @override
  void initState() {
    super.initState();
    fetchTriggers();
  }

  @override
  Widget build(BuildContext context) {
    final token = context.read<Auth>().token;
    final triggers = context.watch<Triggers>().triggers;
    final appBar = generateAppBar('Suggested campaigns');


    void fetchTriggerAndRedirectToTriggerScreen(int index) {
      Provider.of<Campaigns>(context, listen: false).fetchGroupsByTrigger(
        triggers[index].id,
        token
      );
      Navigator.of(context).pushNamed(
        TriggerScreen.routeName,
        arguments: triggers[index]
      );
    }

    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      body: Container(
        padding: const EdgeInsets.only(
          left: 14.0,
          right: 14.0,
          top: 14.0,
          bottom: 30.0
        ),
        decoration: BoxDecoration(
          color: HexColor('E5E5E5'),
        ),
        width: double.infinity,
        height: calculateHeight(context, appBar, 1),
        child: _isLoading && triggers.length == 0
        ? Center(child:
            CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              strokeWidth: 3,
            ),
          )
        :
        RefreshIndicator(
          displacement: 40,
          color: Theme.of(context).primaryColor,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () => _pullTriggersRefresh(context),
          child: triggers.length > 0
          ?
          Opacity(
            opacity: _isLoading ? 0.5 : 1,
            child: Column(
              children: [
                Consumer<Triggers>(
                  builder: (ctx, triggers, _) => Expanded(
                    child: ListView.builder(
                      itemCount: triggers.triggers.length,
                      itemBuilder: (ctx, i) =>
                      GestureDetector(
                        onTap: () => fetchTriggerAndRedirectToTriggerScreen(i),
                        child: TriggerCard(triggers.triggers[i]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          :
          Center(
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