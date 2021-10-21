import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class AppColors {
  static const PrimaryColor = const Color(0xFF1A72DD);

  static Color primaryColor = HexColor('1A72DD');

  static const Color primaryColorLight = CupertinoColors.white;
  static const Color primaryColorDark = CupertinoColors.black;


  static const greyTitle = const Color(0xFF2A3256);
}

