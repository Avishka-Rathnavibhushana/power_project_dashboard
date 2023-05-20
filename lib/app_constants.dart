library app_constants;

import 'package:flutter/cupertino.dart';

const kBorderRadius = 20.0;
const kSpacing = 20.0;

const kFontColorPallets = [
  Color.fromRGBO(0, 0, 0, 1),
  Color.fromRGBO(128, 128, 128, 1),
  Color.fromRGBO(170, 170, 170, 1),
];

const kNotifColor = Color.fromRGBO(74, 177, 120, 1);

class ImageRasterPath {
  static const _folderPath = "assets";
  static const logo1 = "$_folderPath/logo-1.png";
}

class ImageVectorPath {
  static const _folderPath = "assets/vector";
  static const happy = "$_folderPath/happy.svg";
  static const happy2 = "$_folderPath/happy-2.svg";
  static const wavyBus = "$_folderPath/wavy-bus.svg";
}
