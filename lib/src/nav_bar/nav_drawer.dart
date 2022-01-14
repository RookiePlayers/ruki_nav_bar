import 'package:flutter/material.dart';
import 'package:ruki_nav_bar/ruki_nav_bar.dart';
import 'nav_list_tile.dart';
import 'nav_item.dart';
import 'page_tracker_context.dart';

enum NavDrawerMode { full, right, left, collapsableLeft, collapsableRight}

/// This is a navigation drawer, the enum[NavDrawerMode] has 3 options which you can set through the constructor
class NavDrawer extends StatefulWidget {
  final List<NavItem> navItems;
  final Widget? drawerHeader;
  final Widget? drawerBody;
  final Widget? drawerFooter;
  final double? itemSpacing;
  final TextStyle? navTextStyle;
  final BoxDecoration? customDecoration;
  final NavDrawerMode drawerMode;
  final PageIndicator? pageIndicator;
  final NavItemPosition? itemsPosition;
  final double? indicatorLineThickness;
  final VoidCallback? onClose;
  final AnimationType? navItemAnimation;
  final Color? appBarColor;
  final Color? drawerColor;
  final DeviceType? device;
  const NavDrawer(
      {Key? key,
        this.onClose,
        this.appBarColor,
        this.drawerColor,
      required this.navItems,
        this.navItemAnimation,
        this.navTextStyle,
        this.itemSpacing,
        this.itemsPosition = NavItemPosition.center,
        this.customDecoration,
        this.pageIndicator,
        this.indicatorLineThickness,
      this.drawerHeader,
        this.drawerMode = NavDrawerMode.right,
        this.drawerBody,
        this.device,
      this.drawerFooter})
      : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> with TickerProviderStateMixin{
  bool minimize = true;
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    animation = Tween(begin: 0.0,end: 1.0).animate(animationController);
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   Popup(
    //       context,
    //       Text(
    //         "Hi Dick head",
    //         style: TextStyle(
    //             color: Colors.white, fontSize: 12),
    //       ),
    //       backgroundColor: Colors.blue[700]!)
    //       .show();
    // });
    //^^^this will not work without a scaffolded parent
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return (widget.drawerMode == NavDrawerMode.collapsableLeft || widget.drawerMode == NavDrawerMode.collapsableRight) && widget.device != DeviceType.mobile ? _buildCollapsableDrawer() : _buildDefaultDrawer(context);
  }

  Container _buildDefaultDrawer(BuildContext context) {
    return Container(
    height: MediaQuery.of(context).size.height,
    width: widget.drawerMode == NavDrawerMode.full ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.7,
    constraints: BoxConstraints(maxWidth: widget.drawerMode == NavDrawerMode.full ? MediaQuery.of(context).size.width : 300 ),
    child: Drawer(
      backgroundColor: widget.drawerColor ?? Theme.of(context).drawerTheme.backgroundColor,
      child: Column(
        crossAxisAlignment: widget.itemsPosition == NavItemPosition.center ? CrossAxisAlignment.center : widget.itemsPosition == NavItemPosition.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          widget.drawerHeader == null || widget.drawerMode == NavDrawerMode.full ? Container() : DrawerHeader(
            child: widget.drawerHeader ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container()],
                ),
          ),
          widget.drawerMode == NavDrawerMode.full ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(onPressed: (){
              if(widget.onClose!=null) widget.onClose!();
            }, icon: const Icon(Icons.clear_rounded)),
          ):Container(),
          Container(
            height: widget.drawerMode == NavDrawerMode.full ? MediaQuery.of(context).size.height * 0.8 : null,

            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: widget.itemsPosition == NavItemPosition.center ? CrossAxisAlignment.center : widget.itemsPosition == NavItemPosition.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              mainAxisAlignment: widget.itemsPosition == NavItemPosition.center || widget.drawerMode == NavDrawerMode.full ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: widget.navItems
                  .map((e) => Container(
                //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.15),
                alignment: widget.itemsPosition == NavItemPosition.center ? Alignment.center : widget.itemsPosition == NavItemPosition.left ? Alignment.centerLeft : Alignment.centerRight,
                        margin:  EdgeInsets.symmetric(vertical: widget.itemSpacing??10),
                        child: NavListTile(
                          itemPosition: widget.itemsPosition,
                          animationType: widget.navItemAnimation!,
                          customDecoration: widget.customDecoration,
                            navTextStyle: widget.navTextStyle,
                            pageIndicator: widget.pageIndicator!,
                            indicatorLineThickness: widget.indicatorLineThickness,
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
          widget.drawerFooter == null ? Container(): const Divider(height: 2.0,),
          widget.drawerFooter == null ? Container():const Expanded(child: SizedBox(height: 20,)),
          widget.drawerFooter == null ? Container():Align(alignment: Alignment.bottomCenter, child: widget.drawerFooter)
        ],
      ),
    ),
  );
  }

  _buildCollapsableDrawer(){
    return AnimatedContainer(
      width: minimize?60:300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCirc,
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: widget.drawerColor ?? Theme.of(context).drawerTheme.backgroundColor,
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: minimize ? 0 : 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Column(
                          children: [
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  minimize?Container(): widget.drawerHeader??Container(),
                                  Expanded(
                                    child: IconButton(onPressed: (){
                                      setState(() {
                                        minimize = !minimize;
                                        if(!minimize) {
                                          animationController.forward();
                                        } else {
                                          animationController.reverse();
                                        }
                                      });
                                    }, icon: AnimatedIcon(icon:AnimatedIcons.menu_close,progress: animation,)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 1,
                              width: 300,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            Container(
                                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.9,),
                                child: ListView.builder(
                                    itemCount: widget.navItems.length,
                                    shrinkWrap: true,
                                    itemBuilder: (_,index){
                                      widget.navItems[index].minimized = minimize;
                                      return
                                      Container(

                                          //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.15),
                                          alignment: widget.itemsPosition == NavItemPosition.center || minimize ?  Alignment.center : widget.itemsPosition == NavItemPosition.left ? Alignment.centerLeft : Alignment.centerRight,
                                          margin:  EdgeInsets.symmetric(vertical: widget.itemSpacing??10),
                                      child: NavListTile(
                                        itemPosition: widget.itemsPosition,
                                      animationType: widget.navItemAnimation!,
                                      customDecoration: widget.customDecoration,
                                      navTextStyle: widget.navTextStyle,
                                      pageIndicator: widget.pageIndicator!,
                                      indicatorLineThickness: widget.indicatorLineThickness,
                                      selectedPageIndex:
                                      PageTrackerContext.of<int>(context).currentData,
                                      onPageSelected: (index) {
                                            PageTrackerContext.of<int>(context)
                                                .updateData(data: index);
                                          },
                                          data: widget.navItems[index]),
                                    );
                                    }
                                    )
                                ),
                          ],
                        )),
                    widget.drawerFooter == null ? Container():Align(alignment: Alignment.bottomCenter, child: widget.drawerFooter)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
