import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ActionButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
      color: Colors.white,
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black12,
      //     offset: const Offset(
      //       0,
      //       0,
      //     ),
      //     blurRadius: 10,
      //     spreadRadius: 0.1,
      //   ),
      // ],
    ),
      // margin: EdgeInsets.only(top: 12, bottom: 0,),
      // padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: deviceSize.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).primaryColor
              ),
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              minSize: kMinInteractiveDimensionCupertino,
              child: Text(
                'Reject',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              color: Colors.white,
              onPressed: () => {
                Navigator.of(context).pop()
              },
            ),
          ),

          Container(
            width: deviceSize.width * 0.40,
            height: 40,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child:
            CupertinoButton(
              pressedOpacity: 0.5,
              padding: EdgeInsets.all(0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              minSize: kMinInteractiveDimensionCupertino,
              onPressed: () => {
                // Navigator.of(context).pushNamed(AuthScreen.routeName),
              },

              child: Text(
                'Approve',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),

        ],
      ),
    );
  }
}