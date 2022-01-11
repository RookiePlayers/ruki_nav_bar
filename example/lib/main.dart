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
          return SiteNavBar.get(body: Container(),).getNavBar(DeviceType.desktop.currentDevice(constraints.maxWidth));
        },
      )
    );
  }
}
