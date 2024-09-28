import 'package:flutter/material.dart';
class BottomNavWidget extends BottomNavigationBarItem{

  BottomNavWidget(
      double bottom,
      double top,
      String title,
      Color  backgroundColor,
  {
    String? iconPath,
    Icon? mainIcon,

  }
      ): super( icon: Padding(
        padding:  EdgeInsets.only(bottom: bottom,top: top),
        child: mainIcon ?? ImageIcon(AssetImage(iconPath!)),
      ),
    label: title,
    backgroundColor: backgroundColor
  );




}