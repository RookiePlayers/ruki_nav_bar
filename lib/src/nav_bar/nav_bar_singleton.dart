import 'package:flutter/material.dart';
import 'package:ruki_nav_bar/src/nav_bar/page_tracker_context.dart';
import '../../ruki_nav_bar.dart';
import 'default_nav_bar.dart';
import 'device_type.dart';
import 'mob_nav_bar.dart';
import 'nav_bar.dart';
import 'nav_drawer.dart';
import 'nav_item.dart';

class SiteNavBar {
  static SiteNavBar? _navBarInstance;
  final DeviceType type;
  final double? height;
  final Widget title;
  final NavItemPosition? itemsPosition;
  final bool? enableDrawer;
  final NavDrawerMode? drawerMode;
  final double? MAX_PAGE_WIDTH;
  final String? titleText;
  final Color? backgroundColor;
  final Widget? leading;
  final List<NavItem> items;
  final List<Widget>? actions;
  final Widget body;
  final Widget? fab;
  final bool? showFab;
  final double? navItemSpacing;
  final TextStyle?  navTextStyle;
  final PageIndicator? pageIndicator;
  final double? indicatorLineThickness;
  final ShapeDecoration? customDecoration;
  final Widget? drawerHeader;
  final Widget? drawerBody;
  final Widget? drawerFooter;
  SiteNavBar._SiteNavBar({
    this.fab,
    this.drawerFooter,
    this.drawerHeader,
    this.drawerBody,
    this.customDecoration,
    this.indicatorLineThickness,
    this.pageIndicator,
    this.navItemSpacing,
    this.showFab,
    this.height,
    this.navTextStyle,
    required this.body,
    required this.title,
    this.itemsPosition,
    this.enableDrawer,
    this.drawerMode,
    this.MAX_PAGE_WIDTH,
    this.titleText,
    this.backgroundColor,
    this.leading,
    required this.items,
    this.actions,
    this.type = DeviceType.desktop,
  });

  static SiteNavBar get({
    DeviceType type = DeviceType.desktop,
    Widget? title,
    double? height,
    Widget? fab,
    ShapeDecoration? customDecoration,
    Widget? drawerHeader,
    Widget? drawerBody,
    Widget? drawerFooter,
    TextStyle? navTextStyle,
    bool? showFab,
    PageIndicator? pageIndicator,
    double? indicatorLineThickness,
    NavItemPosition? itemPosition,
    String? titleText,
    required Widget body,
    bool? enableDrawer,
    NavDrawerMode? drawerMode,
    Color? backgroundColor,
    double? MAX_PAGE_WIDTH,
    Widget? leading,
    double? navItemSpacing,
    List<Widget>? actions,
    List<NavItem>? navItems,
  }) {
    _navBarInstance ??= SiteNavBar._SiteNavBar(
        type: type,
        title: title ?? Container(),
        enableDrawer: enableDrawer,
        body: body,
        fab: fab,
        customDecoration: customDecoration,
        drawerBody: drawerBody,
        drawerFooter: drawerFooter,
        drawerHeader: drawerHeader,
        navTextStyle: navTextStyle,
        navItemSpacing: navItemSpacing,
        showFab: showFab,
        indicatorLineThickness: indicatorLineThickness,
        pageIndicator: pageIndicator,
        MAX_PAGE_WIDTH: MAX_PAGE_WIDTH,
        itemsPosition: itemPosition,
        drawerMode: drawerMode,
        height: height ?? kToolbarHeight,
        titleText: titleText,
        backgroundColor: backgroundColor,
        actions: actions ?? [],
        items: navItems ?? [],
        leading: leading);
    return _navBarInstance!;
  }

  Widget getNavBar(
    DeviceType device, {
    bool? showFab,
    Widget? title,
    String? titleText,
    double? height,
    Widget? fab,
    bool? enableDrawer,
    NavDrawerMode? drawerMode,
    Color? backgroundColor,
    Widget? leading,
    List<Widget>? actions,
    List<NavItem>? navItems,
  }) {
    Widget child = Container();
    switch (device) {
      case DeviceType.mobile:
        child = MobNavBar(
            title: title ?? this.title,
            navItems: items,
            fab: fab ?? this.fab,
            showFab: showFab ?? this.showFab,
            body: body,
            customDecoration: customDecoration,
            drawerBody: drawerBody,
            drawerFooter: drawerFooter,
            drawerHeader: drawerHeader,
            indicatorLineThickness: indicatorLineThickness,
            pageIndicator: pageIndicator,
            navItemSpacing: navItemSpacing,
            MAX_PAGE_WIDTH: MAX_PAGE_WIDTH,
            itemPosition: itemsPosition,
            drawerMode: drawerMode ?? this.drawerMode,
            height: height ?? this.height,
            navTextStyle: navTextStyle,
            titleText: titleText ?? this.titleText,
            backgroundColor: backgroundColor ?? this.backgroundColor,
            actions: actions ?? this.actions,
            leading: leading ?? this.leading);
        break;
      default:
        child = DefaultNavBar(
            title: title ?? this.title,
            items: items,
            fab: fab ?? this.fab,
            showFab: showFab ?? this.showFab,
            body: body,
            customDecoration: customDecoration,
            drawerBody: drawerBody,
            drawerFooter: drawerFooter,
            drawerHeader: drawerHeader,
            indicatorLineThickness: indicatorLineThickness,
            pageIndicator: pageIndicator,
            enableDrawer: enableDrawer ?? this.enableDrawer,
            navTextStyle: navTextStyle,
            navItemSpacing: navItemSpacing,
            MAX_PAGE_WIDTH: MAX_PAGE_WIDTH,
            itemPosition: itemsPosition,
            drawerMode: drawerMode ?? this.drawerMode,
            height: height ?? this.height,
            titleText: titleText ?? this.titleText,
            backgroundColor: backgroundColor ?? this.backgroundColor,
            actions: actions ?? this.actions,
            leading: leading ?? this.leading);
        break;
    }
    return PageTrackerContext<int>(child: child, currentData: 0);
  }
}