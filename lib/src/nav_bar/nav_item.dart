import 'package:flutter/material.dart';

class NavItem{
  final String label;
  final String? path;
  TextStyle? labelStyle;
  VoidCallback onTap;
  final int relativeIndex; // the relative item index in the list of nav items
  bool? minimized; // whether to only show icon or label also
  final Color? activeColor;
  final Color? activeTextColor;
  final IconData? icon;
  final double? iconSize;
  final bool disableHoverPageIndicator;
  final Color? splashColor;
  final BorderRadius? splashRadius;
  final Color? hoverColor;
  final double? width;
  final double? height;

   NavItem({required this.onTap, required this.relativeIndex,this.iconSize, this.width, this.height, required this.label,this.disableHoverPageIndicator = false, this.splashRadius,this.splashColor = Colors.transparent,this.hoverColor,this.activeTextColor, this.path, this.activeColor, this.icon, this.minimized = false,this.labelStyle});

}