import 'package:flutter/material.dart';

class NavItem{
  final String label;
  final String? path;
  TextStyle? labelStyle;
  VoidCallback onTap;
  final int relativeIndex; // the relative item index in the list of nav items
  bool? minimized; // whether to only show icon or label also
  final Color? activeColor;
  final IconData? icon;

   NavItem({required this.onTap, required this.relativeIndex, required this.label, this.path, this.activeColor, this.icon, this.minimized = false,this.labelStyle});

}