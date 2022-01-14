import 'package:flutter/material.dart';
import 'package:ruki_nav_bar/ruki_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo',
        debugShowCheckedModeBanner: false,
        home: LayoutBuilder(
          builder: (_, constraints) {
            return SiteNavBar.get(
                body: Container(
                  color: Colors.red[100],
                ),
                indicatorLineThickness: 4,
               backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                enableDrawer: true,
                drawerMode: NavDrawerMode.full,
                pageIndicator: PageIndicator.none,
                itemPosition: NavItemPosition.center,
                drawerHeader: Container(),
                navTextStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                drawerFooter: Container(
                  height: 20,
                  color: Colors.grey[200],
                ),
                leading: const Text(
                  "Logo",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
                navItemSpacing: 8,
                navItems: [
                  NavItem(
                      icon: Icons.home,
                      relativeIndex: 0,
                      label: "Home",
                      activeColor: Colors.blue,
                      onTap: () {}),
                  NavItem(
                      relativeIndex: 1,
                      //minimized: true,
                      iconSize: 19,
                      width:360,
                      icon: Icons.extension,
                      label: "About us asdhgasjda sdasdh asdsajh",
                      activeColor: Colors.blue,
                      onTap: () {}),
                  NavItem(
                      relativeIndex: 2,
                      label: "Contact us",
                      activeColor: Colors.blue,
                      onTap: () {}),
                ]).getNavBar(
                DeviceType.desktop.currentDevice(constraints.maxWidth));
          },
        ));
  }
}
