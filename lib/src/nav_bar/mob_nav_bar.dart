
import 'package:flutter/material.dart';
import 'nav_list_tile.dart';
import 'nav_drawer.dart';
import 'nav_item.dart';
import 'nav_bar.dart';
import 'page_tracker_context.dart';
class MobNavBar extends NavBar {

  MobNavBar({
    Key? key,
    required Widget title,
    double? height,
    PageIndicator? pageIndicator,
    double? indicatorLineThickness,
    NavItemPosition? itemPosition,
    String? titleText,
    BoxDecoration? customDecoration,
    Widget? drawerHeader,
    Widget? drawerBody,
    Widget? drawerFooter,
    required Widget body,
    double? navItemSpacing,
    NavDrawerMode? drawerMode,
    Color? backgroundColor,
    Widget? fab,
    TextStyle? navTextStyle,
    bool? showFab,
    double? MAX_PAGE_WIDTH,
    Widget? leading,
    List<Widget>? actions,
    required List<NavItem> navItems,

}) : super(
    key: key,
    title: title,
    body: body,
    fab: fab,
      customDecoration: customDecoration,
      drawerBody: drawerBody,
      drawerFooter: drawerFooter,
      drawerHeader: drawerHeader,
      indicatorLineThickness: indicatorLineThickness,
      pageIndicator: pageIndicator,
    navTextStyle: navTextStyle,
    navItemSpacing: navItemSpacing??10,
    showFab: showFab??false,
    height: height??kToolbarHeight,
    MAX_PAGE_WIDTH: MAX_PAGE_WIDTH??1140,
    items: navItems,
    itemsPosition: itemPosition??NavItemPosition.right,
    enableDrawer: true,
    drawerMode: drawerMode??NavDrawerMode.left,
    titleText: titleText,
    backgroundColor: backgroundColor,
    actions: actions??[],
    leading: leading
  );

  @override
  AppBar buildNavBar(BuildContext context) {
    // TODO: implement buildNavBar
    return AppBar(
      elevation: 0,
      leadingWidth: enableDrawer==true ? 120 : 75,
      leading: Padding(
        padding: const EdgeInsets.only(left:5.0),
        child: Center(child: Row(
          children: [
            enableDrawer ?? false
                ? drawerMode == NavDrawerMode.left ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ) : Container()
                : Container(),
            leading??Container()
          ],
        )),
      ),
      iconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: titleText !=null ? Text(titleText??""):title,
          ),
        ],
      ) ,
      actions: [
        ...?actions,
        enableDrawer ?? false
            ? drawerMode == NavDrawerMode.right || drawerMode == NavDrawerMode.full ? IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openEndDrawer();
          },
        ) : Container()
            : Container(),
      ],
    );
  }

}