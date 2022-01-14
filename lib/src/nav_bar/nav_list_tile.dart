import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../ruki_nav_bar.dart';
import 'nav_item.dart';

import 'page_tracker_context.dart';

enum PageIndicator { line, filled, outlined, none }
enum AnimationType { stretch, grow, fade }

class NavListTile extends StatefulWidget {
  final NavItem data;
  final TextStyle? navTextStyle;
  final Function(int) onPageSelected;
  final int selectedPageIndex;
  final PageIndicator? pageIndicator;
  final double? indicatorLineThickness;
  final  NavItemPosition? itemPosition;
  final bool? enableRouteNavigation;
  final BoxDecoration? customDecoration;
  final AnimationType animationType;
  const NavListTile(
      {Key? key,
       required this.itemPosition,
      this.enableRouteNavigation = true,
      this.animationType = AnimationType.fade,
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

class _NavListTileState extends State<NavListTile>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double scale =
        (widget.animationType == AnimationType.grow && isHovered) ? 1.05 : 1.0;

    bool isFilled = widget.pageIndicator == PageIndicator.filled;
    bool isOutlined = widget.pageIndicator == PageIndicator.outlined;
    bool isLine = widget.pageIndicator == PageIndicator.line;
    Color hoverColor = (widget.data.hoverColor ??
        (widget.customDecoration?.color ?? widget.data.activeColor)!
            .withOpacity(0.4));
    bool isCurrent = PageTrackerContext.of<int>(context).currentData ==
        widget.data.relativeIndex;
    BoxDecoration? customDecoration = widget.customDecoration != null
        ? widget.customDecoration!.copyWith(
            color: widget.pageIndicator == PageIndicator.filled
                ? isHovered
                    ? hoverColor
                    : (widget.customDecoration?.color ??
                        widget.data.activeColor)
                : Colors.transparent)
        : null;
    Color? labelColor = isCurrent ? isFilled
        ? widget.data.activeTextColor ?? Colors.white : widget.data.activeColor
        : isHovered
        ? isFilled
        ? widget.data
        .activeTextColor ??
        Colors.white
        : widget.data.activeColor : null;
    BoxDecoration? decoration = (isFilled || isOutlined) &&
            (isCurrent || (isHovered && !widget.data.disableHoverPageIndicator))
        ? (widget.customDecoration != null
            ? customDecoration
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: !isOutlined
                        ? Colors.transparent
                        : isHovered
                            ? hoverColor
                            : widget.data.activeColor ?? Colors.black,
                    width: !isOutlined ? 0 : 2),
                color: widget.pageIndicator == PageIndicator.filled
                    ? isHovered
                        ? hoverColor
                        : widget.data.activeColor
                    : Colors.transparent))
        : BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          );

    if (widget.navTextStyle != null) {
      widget.data.labelStyle = widget.navTextStyle;
    }
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          isHovered = true;
          _controller.forward();
        });
      },
      onExit: (e) {
        setState(() {
          isHovered = false;
          _controller.reverse();
        });
      },
      child: widget.data.minimized ?? false
          ? InkWell(
        hoverColor: Colors.transparent,
        borderRadius:
        widget.data.splashRadius ?? BorderRadius.circular(10),
        splashColor: widget.data.splashColor ??
            (widget.data.activeColor ?? Colors.grey).withOpacity(0.3),
        splashFactory: widget.data.splashColor == Colors.transparent
            ? NoSplash.splashFactory
            : InkSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: () {
          widget.onPageSelected(widget.data.relativeIndex);
          widget.data.onTap();
        },
              child:AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: Matrix4(
                    scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
                decoration: decoration,
                padding: const EdgeInsets.all(5),
                child: Icon(widget.data.icon,
                    size: widget.data.iconSize,
                    color:labelColor ?? (widget.data.labelStyle != null ? widget.data.labelStyle!.color : Theme.of(context)
                        .iconTheme
                        .color!
                        .withOpacity(0.5))),
              ) ,
            )
          : InkWell(
              hoverColor: Colors.transparent,
              borderRadius:
                  widget.data.splashRadius ?? BorderRadius.circular(10),
              splashColor: widget.data.splashColor ??
                  (widget.data.activeColor ?? Colors.grey).withOpacity(0.3),
              splashFactory: widget.data.splashColor == Colors.transparent
                  ? NoSplash.splashFactory
                  : InkSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                widget.onPageSelected(widget.data.relativeIndex);
                widget.data.onTap();
              },
              child: AnimatedContainer(
                transform: Matrix4.identity()..scale(scale,scale),
                decoration: decoration,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                constraints:  BoxConstraints(maxHeight: widget.data.height??30,maxWidth: widget.data.width??double.infinity),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: widget.itemPosition == NavItemPosition.center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.data.icon != null
                                ?  Flexible(
                                  child: Container(
                                    child: Icon(widget.data.icon,
                                        color: labelColor ?? (widget.data.labelStyle != null ? widget.data.labelStyle!.color : Theme.of(context)
                                                .iconTheme
                                                .color!
                                                .withOpacity(0.5))),
                                  ),
                                )
                                : Container(),
                            SizedBox(
                              width: widget.data.icon != null ? 8 : 0,
                            ),
                            Flexible(
                              flex: 3,
                              fit: widget.itemPosition == NavItemPosition.center ? FlexFit.loose : FlexFit.tight,
                              child: AutoSizeText(widget.data.label,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  style: widget.data.labelStyle != null
                                      ? widget.data.labelStyle!.copyWith(
                                          color: labelColor ?? widget.data.labelStyle!.color)
                                      : TextStyle(
                                          color: labelColor ?? Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith()
                                                  .color)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isLine ? 1 : 0,
                    ),
                    !isLine
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: AnimatedContainer(
                              duration: Duration(
                                  milliseconds: widget.animationType ==
                                          AnimationType.fade
                                      ? 500
                                      : 0),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: widget.indicatorLineThickness,
                              width: (isCurrent ||
                                      (isHovered &&
                                          !widget.data
                                              .disableHoverPageIndicator))
                                  ? 100
                                  : 0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: isCurrent || isHovered
                                      ? isHovered
                                          ? hoverColor
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

  Container buildMinimized(BuildContext context, Color? labelColor) {
    return Container(
                height: 40,
                constraints: const BoxConstraints(maxWidth: 100),
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
                          height: PageTrackerContext.of<int>(context)
                                          .currentData ==
                                      widget.data.relativeIndex ||
                                  isHovered
                              ? 30
                              : 0,
                          width: widget.pageIndicator == PageIndicator.line
                              ? widget.indicatorLineThickness
                              : 0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PageTrackerContext.of<int>(context)
                                              .currentData ==
                                          widget.data.relativeIndex ||
                                      isHovered
                                  ? widget.pageIndicator ==
                                          PageIndicator.filled
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
                                color:labelColor ?? (widget.data.labelStyle != null ? widget.data.labelStyle!.color : Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.5))))),
                  ],
                ),
              );
  }
}
