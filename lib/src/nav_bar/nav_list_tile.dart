
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'nav_item.dart';

import 'page_tracker_context.dart';


class NavListTile extends StatefulWidget {
  final NavItem data;
  final Function (int) onPageSelected;
  final int selectedPageIndex;
  const NavListTile({Key? key,  required this.selectedPageIndex,required this.onPageSelected,required this.data,}) : super(key: key);

  @override
  _NavListTileState createState() => _NavListTileState();
}

class _NavListTileState extends State<NavListTile> {
  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(
      duration:const Duration(milliseconds: 200),
      transitionBuilder: (child,animation)=>FadeTransition(opacity: animation,child: child,),
      child: widget.data.minimized! ? InkWell(
        onTap: (){
          widget.onPageSelected(widget.data.relativeIndex);
        },
        child: Container(
          height: 40,
          color: PageTrackerContext.of<int>(context).currentData  == widget.data.relativeIndex ? Theme.of(context).backgroundColor.withOpacity(0.1) : Colors.transparent,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(padding: const EdgeInsets.only(right: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInToLinear,
                    height: PageTrackerContext.of<int>(context).currentData == widget.data.relativeIndex ? 30 : 0,
                    width: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:PageTrackerContext.of<int>(context).currentData  == widget.data.relativeIndex ?widget.data.activeColor:Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                  ),

                ),
              ),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: const Alignment(-0.5,0),
                      child: Icon(widget.data.icon,color:PageTrackerContext.of<int>(context).currentData  == widget.data.relativeIndex ?widget.data.activeColor:Theme.of(context).iconTheme.color!.withOpacity(0.5)))),
            ],
          ),
        ),
      ):
      InkWell(
        onTap: (){
          widget.onPageSelected(widget.data.relativeIndex);
        },
        child: Container(
          constraints:const BoxConstraints(maxHeight: 30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.data.icon != null ? Icon(widget.data.icon,color:PageTrackerContext.of<int>(context).currentData  == widget.data.relativeIndex ?widget.data.activeColor:Theme.of(context).iconTheme.color!.withOpacity(0.5)):Container(),
                    SizedBox(width: widget.data.icon != null ? 8 :0,),
                    AutoSizeText(widget.data.label,maxLines: 1,style:TextStyle(
                        fontFamily:"Roboto",
                        color: PageTrackerContext.of<int>(context).currentData  == widget.data.relativeIndex ?widget.data.activeColor:Theme.of(context).textTheme.bodyText1!.color
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 1,),
              Expanded(
                child: Padding(padding: const EdgeInsets.only(top: 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInToLinear,
                    height: 3,
                    width: PageTrackerContext.of<int>(context).currentData == widget.data.relativeIndex ? 100 : 0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:PageTrackerContext.of<int>(context).currentData  == widget.data.relativeIndex ?widget.data.activeColor:Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
