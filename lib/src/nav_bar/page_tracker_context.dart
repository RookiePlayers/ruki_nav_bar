import 'package:flutter/material.dart';

import 'page_tracker_provider.dart';

class PageTrackerContext<T> extends StatefulWidget {
  final Widget child;
  final T currentData;


  const PageTrackerContext(
      {Key? key, required this.child, required this.currentData})
      : super(key: key);

  /// your implementation must define the generic otherwise you'll get this error:
  /// Expected a value of type 'PageTrackerProvider<dynamic>', but got one of type 'Null'

  static PageTrackerContextState<S> of<S>(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<PageTrackerProvider<S>>() as PageTrackerProvider<S>).data;
  }

  @override
  PageTrackerContextState<T> createState() =>
      PageTrackerContextState<T>(currentData: this.currentData);
}

class PageTrackerContextState<T> extends State<PageTrackerContext> {
  T currentData;

  PageTrackerContextState({required this.currentData});

  void updateData({required T data}) {
    setState(() {
      currentData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTrackerProvider<T>(
      data: this,
      child: Scaffold(body: widget.child),
    );
  }
}