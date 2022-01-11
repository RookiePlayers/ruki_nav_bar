import 'package:flutter/material.dart';
import 'nav_list_tile.dart';
import 'nav_item.dart';
import 'page_tracker_context.dart';

enum NavDrawerMode { full, right, left }

/// This is a navigation drawer, the enum[NavDrawerMode] has 3 options which you can set through the constructor
class NavDrawer extends StatelessWidget {
  final List<NavItem> navItems;
  final Widget? drawerHeader;
  final Widget? drawerBody;
  final Widget? drawerFooter;
  final NavDrawerMode drawerMode;
  const NavDrawer(
      {Key? key,
      required this.navItems,
      this.drawerHeader,
        this.drawerMode = NavDrawerMode.right,
        this.drawerBody,
      this.drawerFooter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: drawerMode == NavDrawerMode.full ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.7,
      constraints: BoxConstraints(maxWidth: drawerMode == NavDrawerMode.full ? MediaQuery.of(context).size.width : 300 ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader == null ? Container() : DrawerHeader(
              child: drawerHeader ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Container()],
                  ),
            ),
            Column(
              children: navItems
                  .map((e) => Container(
                        margin: const EdgeInsets.all(10),
                        child: NavListTile(
                            selectedPageIndex:
                                PageTrackerContext.of<int>(context).currentData,
                            onPageSelected: (index) {
                              PageTrackerContext.of<int>(context)
                                  .updateData(data: index);
                            },
                            data: e),
                      ))
                  .toList(),
            ),
            Align(alignment: FractionalOffset.bottomCenter, child: drawerFooter)
          ],
        ),
      ),
    );
  }
}
