import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../helpers/helpers.dart';
import '../providers/triggers.dart';
import '../providers/auth.dart';
import '../widgets/general/AppDrawer.dart';
import '../widgets/campaign/TriggerCard.dart';
import '../screens/TriggerScreen.dart';

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
    final triggers = context.watch<Triggers>().triggers;
    final appBar = generateAppBar('Suggested campaigns');

    void fetchTriggerAndRedirectToTriggerScreen(int index) {
      Navigator.of(context).pushNamed(
        TriggerScreen.routeName,
        arguments: triggers[index]
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      drawer: AppDrawer(),
      body: Container(
        width: double.infinity,
        color: HexColor('E5E5E5'),
        padding: const EdgeInsets.only(
          left: 14.0,
          right: 14.0,
          top: 14.0,
          bottom: 30.0
        ),
        child: _isLoading && triggers.length == 0
          ?
          Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 16,
            ),
          )
          :
          RefreshIndicator(
          displacement: 140,
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
                        onTap: () => _isLoading
                          ? null
                          : fetchTriggerAndRedirectToTriggerScreen(i),
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