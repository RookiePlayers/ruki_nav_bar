import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'nav_item.dart';

import 'page_tracker_context.dart';

enum PageIndicator { line, filled, outlined, none }

class NavListTile extends StatefulWidget {
  final NavItem data;
  final TextStyle? navTextStyle;
  final Function(int) onPageSelected;
  final int selectedPageIndex;
  final PageIndicator? pageIndicator;
  final double? indicatorLineThickness;
  final bool? enableRouteNavigation;
  final ShapeDecoration? customDecoration;
  const NavListTile(
      {Key? key,
      this.enableRouteNavigation = true,
      this.indicatorLineThickness = 4,
      this.customDecoration,
      this.pageIndicator = PageIndicator.line,
      required this.selectedPageIndex,
      required this.onPageSelected,
      required this.data,
      this.navTextStyle})
      : super(key: key);

  @override
  _NavListTileState createState() => _NavListTileState();
}

class _NavListTileState extends State<NavListTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.navTextStyle != null) {
      widget.data.labelStyle = widget.navTextStyle;
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: widget.data.minimized!
          ? InkWell(
              onTap: () {
                widget.onPageSelected(widget.data.relativeIndex);
                widget.data.onTap();
              },
              child: Container(
                height: 40,
                color: PageTrackerContext.of<int>(context).currentData ==
                        widget.data.relativeIndex
                    ? Theme.of(context).backgroundColor.withOpacity(0.1)
                    : Colors.transparent,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInToLinear,
                          height:
                              PageTrackerContext.of<int>(context).currentData ==
                                      widget.data.relativeIndex
                                  ? 30
                                  : 0,
                          width: widget.pageIndicator == PageIndicator.line
                              ? widget.indicatorLineThickness
                              : 0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PageTrackerContext.of<int>(context)
                                          .currentData ==
                                      widget.data.relativeIndex
                                  ? widget.pageIndicator == PageIndicator.filled
                                      ? Colors.white
                                      : widget.data.activeColor
                                  : Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(0.5)),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Align(
                            alignment: const Alignment(-0.5, 0),
                            child: Icon(widget.data.icon,
                                color: PageTrackerContext.of<int>(context)
                                            .currentData ==
                                        widget.data.relativeIndex
                                    ? widget.pageIndicator ==
                                            PageIndicator.filled
                                        ? Colors.white
                                        : widget.data.activeColor
                                    : Theme.of(context)
                                        .iconTheme
                                        .color!
                                        .withOpacity(0.5)))),
                  ],
                ),
              ),
            )
          : InkWell(
              onTap: () {
                widget.onPageSelected(widget.data.relativeIndex);
                widget.data.onTap();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                constraints: const BoxConstraints(maxHeight: 30),
                decoration: (widget.pageIndicator == PageIndicator.filled || widget.pageIndicator ==
                    PageIndicator.outlined) &&
                        PageTrackerContext.of<int>(context).currentData ==
                            widget.data.relativeIndex
                    ? (
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: widget.pageIndicator == PageIndicator.filled ? Colors.transparent : widget.data.activeColor??Colors.black,width: 2),
                            color: widget.pageIndicator == PageIndicator.filled ? widget.data.activeColor : Colors.transparent))
                    : widget.customDecoration,
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
                          widget.data.icon != null
                              ? Icon(widget.data.icon,
                                  color: PageTrackerContext.of<int>(context)
                                              .currentData ==
                                          widget.data.relativeIndex
                                      ? widget.pageIndicator ==
                                              PageIndicator.filled
                                          ? Colors.white
                                          : widget.data.activeColor
                                      : Theme.of(context)
                                          .iconTheme
                                          .color!
                                          .withOpacity(0.5))
                              : Container(),
                          SizedBox(
                            width: widget.data.icon != null ? 8 : 0,
                          ),
                          AutoSizeText(widget.data.label,
                              maxLines: 1,
                              style: widget.data.labelStyle != null
                                  ? widget.data.labelStyle!.copyWith(
                                      color: PageTrackerContext.of<int>(context)
                                                  .currentData ==
                                              widget.data.relativeIndex
                                          ? widget.data.activeColor
                                          : widget.data.labelStyle!.color)
                                  : TextStyle(
                                      fontFamily: "Roboto",
                                      color: PageTrackerContext.of<int>(context)
                                                  .currentData ==
                                              widget.data.relativeIndex
                                          ? widget.pageIndicator ==
                                                  PageIndicator.filled
                                              ? Colors.white
                                              : widget.data.activeColor
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInToLinear,
                        height: widget.pageIndicator == PageIndicator.line
                            ? widget.indicatorLineThickness
                            : 0,
                        width:
                            PageTrackerContext.of<int>(context).currentData ==
                                    widget.data.relativeIndex
                                ? 100
                                : 0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PageTrackerContext.of<int>(context)
                                        .currentData ==
                                    widget.data.relativeIndex
                                ? widget.pageIndicator == PageIndicator.filled
                                    ? Colors.white
                                    : widget.data.activeColor
                                : Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
