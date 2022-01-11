
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
    NavItemPosition? itemPosition,
    String? titleText,
    required Widget body,
    NavDrawerMode? drawerMode,
    Color? backgroundColor,
    Widget? fab,
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
      actions: [...?actions,enableDrawer??false ? IconButton(
      icon: new Icon(Icons.menu),
      onPressed: () {
        scaffoldKey.currentState!.openEndDrawer();
      },
    ):Container(),],
    );
  }

}