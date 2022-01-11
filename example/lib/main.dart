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
        builder: (_,constraints){
          return SiteNavBar.get(
            body: Container(
              color: Colors.grey[100],
            ),
            indicatorLineThickness: 4,

            drawerMode: NavDrawerMode.full,
            pageIndicator: PageIndicator.outlined,
            itemPosition: NavItemPosition.right,
            drawerHeader: Container(),
            drawerFooter: Container(height: 50,color: Colors.grey[200],),
            leading: const Text("Logo",style: TextStyle(color: Colors.red,fontSize: 30),),
            navItemSpacing: 8,
            navItems: [
              NavItem(relativeIndex: 0, label: "Home", activeColor: Colors.blue, onTap: (){}),
              NavItem(relativeIndex: 1, label: "About us",activeColor: Colors.blue, onTap: (){}),
              NavItem(relativeIndex: 2, label: "Contact us",activeColor: Colors.blue, onTap: (){}),
            ]
          ).getNavBar(DeviceType.desktop.currentDevice(constraints.maxWidth));
        },
      )
    );
  }
}
