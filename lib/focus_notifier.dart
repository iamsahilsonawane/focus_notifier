library focus_notifier;

export './focus_notification.dart';

import 'package:flutter/material.dart';
import 'focus_notification.dart';

typedef FocusNotifierBuilder = Widget Function(
    BuildContext context, FocusNode focusNode);

///Wrap this widget over a focus widget.
///
///Assign the focus node to the child focus widget
///
///Use [key] to add custom key for referenceing it in the listener. 
class FocusNotifier extends StatefulWidget {
  const FocusNotifier({Key? key, required this.builder})
      : super(key: key);

  final FocusNotifierBuilder builder;

  @override
  State<FocusNotifier> createState() => _FocusNotifierState();
}

class _FocusNotifierState extends State<FocusNotifier> {
  final node = FocusNode();

  @override
  initState() {
    node.addListener(() {
      if (node.hasFocus) {
        final notification = FocusNotification(widget.key ?? UniqueKey());
        notification.dispatch(context);
      }
    });
    super.initState();
  }

  @override
  dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, node);
}
