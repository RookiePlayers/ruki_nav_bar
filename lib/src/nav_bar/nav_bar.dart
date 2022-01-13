import 'package:flutter/material.dart';
import 'package:ruki_nav_bar/ruki_nav_bar.dart';
import 'nav_drawer.dart';
import 'nav_item.dart';
import 'page_tracker_context.dart';

enum NavItemPosition { left, right, center }

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
  final TextStyle? navTextStyle;
  final PageIndicator? pageIndicator;
  final double? indicatorLineThickness;
  final BoxDecoration? customDecoration;
  final Widget? drawerHeader;
  final Widget? drawerBody;
  final Widget? drawerFooter;

  @override
  Size get preferredSize => Size.fromHeight(height!);

  final String? titleText;
  final Color? backgroundColor;
  final double? elevation;
  final bool? extendBodyBehindAppBar;
  final Widget? leading;
  final List<NavItem> items;
  final List<Widget>? actions;
  final double navItemSpacing;
  final AnimationType? navItemAnimation;
  NavBar(
      {Key? key,
      required this.title,
        this.navItemAnimation,
        this.elevation,
        this.extendBodyBehindAppBar,
      this.height = kToolbarHeight,
      this.drawerFooter,
      this.drawerHeader,
      this.drawerBody,
      this.pageIndicator,
      this.indicatorLineThickness,
      required this.body,
      this.customDecoration,
      this.navTextStyle,
      this.fab,
      this.navItemSpacing = 10,
      this.showFab = false,
      this.enableDrawer = false,
      this.MAX_PAGE_WIDTH = 1140,
      this.drawerMode = NavDrawerMode.right,
      this.itemsPosition = NavItemPosition.right,
      this.titleText,
      this.backgroundColor,
      required this.items,
      this.actions,
      this.leading})
      : super(key: key, child: title, preferredSize: Size.fromHeight(height!));

  AppBar buildNavBar(BuildContext context);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildNavBar(context),
      extendBodyBehindAppBar: extendBodyBehindAppBar??false,
      key: scaffoldKey,
      floatingActionButton: showFab ? fab : null,
      drawer: (enableDrawer == true && drawerMode == NavDrawerMode.left) ? buildNavDrawer(context) : null,
      endDrawer:  (enableDrawer == true && (drawerMode == NavDrawerMode.right || drawerMode == NavDrawerMode.full))
          ? buildNavDrawer(context)
          : null,
      body: body,
    );
  }

  NavDrawer buildNavDrawer(BuildContext context) {
    return NavDrawer(
            navItems: items,
        onClose: (){
              Navigator.pop(context);
        },
        customDecoration: customDecoration,
        navItemAnimation:navItemAnimation??AnimationType.fade,
            drawerHeader: drawerHeader,
        navTextStyle: navTextStyle,
            drawerBody: drawerBody,
            itemsPosition: itemsPosition,
            drawerFooter: drawerFooter,
            drawerMode: drawerMode ?? NavDrawerMode.right,
            itemSpacing: navItemSpacing,
            pageIndicator: pageIndicator ?? PageIndicator.none,
            indicatorLineThickness: indicatorLineThickness);
  }
}
