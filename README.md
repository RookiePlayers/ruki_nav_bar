<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This Package makes it easy for you to create a responsive web app by handling the navigation bar for you, There's a tonne of customization options, and we'll continue to support improvements and more features.
![img1](https://github.com/RookiePlayers/ruki_nav_bar/blob/master/example/screenshots/Screenshot%202022-01-11%20at%2017.45.57.png)
> desktop nav_bar

![img1](https://github.com/RookiePlayers/ruki_nav_bar/blob/master/example/screenshots/Screenshot%202022-01-11%20at%2017.44.55.png)
> mobile nav_bar

![img1](https://github.com/RookiePlayers/ruki_nav_bar/blob/master/example/screenshots/Screenshot%202022-01-11%20at%2017.45.07.png)
> mobile drawer menu (full mode)



## Usage

Find an example for package usage inside the `/example` folder. 

```dart
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

```

## API Reference

|Name|Object-type
|---------|-----------------|
|type|DeviceType|
|height|double|
|title|Widget|
|itemsPosition|NavItemPosition|
|enableDrawer|bool|
|MAX_PAGE_WIDTH|double|
|titleText|String|
|backgroundColor|Color|
|leading|Widget|
|items|List<NavItem>|
|actions|List<Widget>|
|fab|Widget|
|showFab|bool|
|navItemSpacing|double|
|pageIndicator|double|
|indicatorLineThickness|double|
|customDecoration|ShapeDecoration|
|drawerHeader|Widget|
|drawerBody|Widget|
|drawerFooter|Widget|

