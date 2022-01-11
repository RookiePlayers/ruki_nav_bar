import 'package:flutter/material.dart';

import 'nav_drawer.dart';
import 'nav_item.dart';
import 'nav_bar.dart';
import 'nav_list_tile.dart';
import 'page_tracker_context.dart';

class DefaultNavBar extends NavBar {
  DefaultNavBar({
    Key? key, required Widget title,
    bool? enableDrawer,
    double? height,
    NavItemPosition? itemPosition,
    String? titleText,
    NavDrawerMode? drawerMode,
    Widget? fab,
    bool? showFab,
    Color? backgroundColor,
    required Widget body,
    double? MAX_PAGE_WIDTH,
    Widget? leading,
    required List<NavItem> items,
    List<Widget>? actions
  }) : super(
      key: key,
      fab: fab,
      showFab: showFab??false,
      body: body,
      enableDrawer: enableDrawer??false,
      title: title,
      MAX_PAGE_WIDTH: MAX_PAGE_WIDTH??1140,
      itemsPosition: itemPosition??NavItemPosition.right,
      drawerMode: drawerMode??NavDrawerMode.left,
      height: height??kToolbarHeight,
      titleText: titleText,
      backgroundColor: backgroundColor,
      actions: actions??[],
      items: items,
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
      title:  Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          constraints: BoxConstraints(maxWidth: MAX_PAGE_WIDTH),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: titleText !=null ? Text(titleText??""):title,
                    ),
                  )),
              Expanded(
                flex: 8,
                child: Container(
                  constraints:  BoxConstraints(
                      maxWidth: MAX_PAGE_WIDTH * 0.8),
                  child: Row(

                    children:items
                        .map((e){ e.minimized=false;
                        return Expanded(
                      child: Container(
                        alignment: itemsPosition == NavItemPosition.center ?  Alignment.center : itemsPosition == NavItemPosition.left ? Alignment.centerLeft : Alignment.centerRight,
                          margin: const EdgeInsets.symmetric(
                              vertical: 3),
                          child: NavListTile(
                            data: e,
                            selectedPageIndex:
                            PageTrackerContext.of<int>(context)
                                .currentData,
                            onPageSelected: (index) {
                              PageTrackerContext.of<int>(context)
                                  .updateData(data: index);
                            },
                          )),
                    );
                    })
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
     actions: [...?actions,enableDrawer??false ? IconButton(
       icon: new Icon(Icons.menu),
       onPressed: () {
         scaffoldKey.currentState!.openEndDrawer();
       },
     ):Container(),],
    );
  }

}