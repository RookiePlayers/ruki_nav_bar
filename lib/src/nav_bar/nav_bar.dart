import 'package:flutter/material.dart';
import 'nav_drawer.dart';
import 'nav_item.dart';
import 'page_tracker_context.dart';

enum NavItemPosition{
  left,
  right,
  center
}

abstract class NavBar extends PreferredSize {
  final double? height;
  final Widget title;
  final NavItemPosition? itemsPosition;
  final bool? enableDrawer;
  final NavDrawerMode? drawerMode;
  final double MAX_PAGE_WIDTH;
  final Widget body;
  final Widget? fab;
  final bool showFab;
  @override
  Size get preferredSize => Size.fromHeight(height!);

  final String? titleText;
  final Color? backgroundColor;
  final Widget? leading;
  final List<NavItem> items;
  final List<Widget>? actions;

   NavBar({Key? key, required this.title,
    this.height = kToolbarHeight,
     required this.body,
     this.fab,
     this.showFab = false,
     this.enableDrawer = false,
     this.MAX_PAGE_WIDTH = 1140,
     this.drawerMode = NavDrawerMode.right,
     this.itemsPosition = NavItemPosition.right,
     this.titleText,
    this.backgroundColor,
     required this.items,
      this.actions,
    this.leading}) : super(key: key, child: title, preferredSize: Size.fromHeight(height!));

   AppBar buildNavBar(BuildContext context);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: buildNavBar(context),
        key: scaffoldKey,
        floatingActionButton: showFab ? fab : null,
        endDrawer: enableDrawer??false ? NavDrawer(navItems: items) : null,
        body: body,

    );
  }

}
