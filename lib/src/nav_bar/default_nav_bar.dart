import 'package:flutter/material.dart';

import 'nav_drawer.dart';
import 'nav_item.dart';
import 'nav_bar.dart';
import 'nav_list_tile.dart';
import 'page_tracker_context.dart';

class DefaultNavBar extends NavBar {
  DefaultNavBar(
      {Key? key,
      required Widget title,
      bool? enableDrawer,
      PageIndicator? pageIndicator,
      double? indicatorLineThickness,
      double? height,
      NavItemPosition? itemPosition,
      double? navItemSpacing,
      TextStyle? navTextStyle,
      String? titleText,
      NavDrawerMode? drawerMode,
      Widget? fab,
      bool? showFab,
        BoxDecoration? customDecoration,
        Widget? drawerHeader,
        Widget? drawerBody,
        Widget? drawerFooter,
      Color? backgroundColor,
      required Widget body,
      double? MAX_PAGE_WIDTH,
      Widget? leading,
      required List<NavItem> items,
      List<Widget>? actions})
      : super(
            key: key,
            fab: fab,
            indicatorLineThickness: indicatorLineThickness,
            pageIndicator: pageIndicator,
            navItemSpacing: navItemSpacing ?? 10,
            showFab: showFab ?? false,
            body: body,
          customDecoration: customDecoration,
          drawerBody: drawerBody,
          drawerFooter: drawerFooter,
          drawerHeader: drawerHeader,
          enableDrawer: enableDrawer ?? false,
            navTextStyle: navTextStyle,
            title: title,
            MAX_PAGE_WIDTH: MAX_PAGE_WIDTH ?? 1140,
            itemsPosition: itemPosition ?? NavItemPosition.right,
            drawerMode: drawerMode ?? NavDrawerMode.left,
            height: height ?? kToolbarHeight,
            titleText: titleText,
            backgroundColor: backgroundColor,
            actions: actions ?? [],
            items: items,
            leading: leading);

  @override
  AppBar buildNavBar(BuildContext context) {
    // TODO: implement buildNavBar
    return AppBar(

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
      leadingWidth: enableDrawer==true ? 120 : 75,
      elevation: 0,
      iconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(

          constraints: BoxConstraints(maxWidth: MAX_PAGE_WIDTH),
          child: Row(
            mainAxisAlignment: itemsPosition == NavItemPosition.center
                ? MainAxisAlignment.center
                : itemsPosition == NavItemPosition.left
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Row(children: [title,...( enableDrawer??false ? [] : _buildNavList(context))]),
                  ],
          ),
        ),
      ),
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

  List<Widget> _buildNavList(BuildContext context) {
    return items.map((e) {
      e.minimized = false;
      return Container(
          margin: EdgeInsets.symmetric(
              horizontal: navItemSpacing, vertical: 3),
          alignment: itemsPosition == NavItemPosition.center
              ? Alignment.center
              : itemsPosition == NavItemPosition.left
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: NavListTile(
            data: e,
            navTextStyle: navTextStyle,
            customDecoration: customDecoration,
            pageIndicator: pageIndicator??PageIndicator.none,
            indicatorLineThickness: indicatorLineThickness,
            selectedPageIndex:
            PageTrackerContext.of<int>(context).currentData,
            onPageSelected: (index) {
              PageTrackerContext.of<int>(context)
                  .updateData(data: index);
            },
          ));
    }).toList();
  }
}
