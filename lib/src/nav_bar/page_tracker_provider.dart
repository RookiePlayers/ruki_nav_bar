import 'package:flutter/material.dart';
import 'page_tracker_context.dart';

class PageTrackerProvider<T> extends InheritedWidget {
  final PageTrackerContextState<T> data;

  const PageTrackerProvider({Key? key, required Widget child, required this.data})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}