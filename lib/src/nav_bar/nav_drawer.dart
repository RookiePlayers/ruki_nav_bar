import 'package:flutter/material.dart';
import 'package:ruki_nav_bar/ruki_nav_bar.dart';
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
  final double? itemSpacing;
  final ShapeDecoration? customDecoration;
  final NavDrawerMode drawerMode;
  final PageIndicator? pageIndicator;
  final NavItemPosition? itemsPosition;
  final double? indicatorLineThickness;
  final VoidCallback? onClose;
  const NavDrawer(
      {Key? key,
        this.onClose,
      required this.navItems,
        this.itemSpacing,
        this.itemsPosition = NavItemPosition.center,
        this.customDecoration,
        this.pageIndicator,
        this.indicatorLineThickness,
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
        child: Column(
          crossAxisAlignment: itemsPosition == NavItemPosition.center ? CrossAxisAlignment.center : itemsPosition == NavItemPosition.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            drawerHeader == null || drawerMode == NavDrawerMode.full ? Container() : DrawerHeader(
              child: drawerHeader ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Container()],
                  ),
            ),
            drawerMode == NavDrawerMode.full ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(onPressed: (){
                if(onClose!=null) onClose!();
              }, icon: const Icon(Icons.clear_rounded)),
            ):Container(),
            Container(
              height: drawerMode == NavDrawerMode.full ? MediaQuery.of(context).size.height * 0.8 : null,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: itemsPosition == NavItemPosition.center ? CrossAxisAlignment.center : itemsPosition == NavItemPosition.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                mainAxisAlignment: itemsPosition == NavItemPosition.center || drawerMode == NavDrawerMode.full ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: navItems
                    .map((e) => Container(
                  alignment: itemsPosition == NavItemPosition.center ? Alignment.center : itemsPosition == NavItemPosition.left ? Alignment.centerLeft : Alignment.centerRight,
                          margin:  EdgeInsets.symmetric(vertical: itemSpacing??10),
                          child: NavListTile(
                            customDecoration: customDecoration,
                              pageIndicator: pageIndicator!,
                              indicatorLineThickness: indicatorLineThickness,
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
            ),
            drawerFooter == null ? Container(): const Divider(height: 2.0,),
            drawerFooter == null ? Container():const Expanded(child: SizedBox(height: 20,)),
            drawerFooter == null ? Container():Align(alignment: Alignment.bottomCenter, child: drawerFooter)
          ],
        ),
      ),
    );
  }
}
