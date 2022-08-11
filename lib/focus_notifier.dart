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
  const FocusNotifier({Key? key, required this.builder}) : super(key: key);

  final FocusNode? customFocusNode;
  final FocusNotifierBuilder builder;

  @override
  State<FocusNotifier> createState() => _FocusNotifierState();
}

class _FocusNotifierState extends State<FocusNotifier> {
  FocusNode node = FocusNode();

  @override
  initState() {
    if (widget.customFocusNode != null) {
      node = widget.customFocusNode;
    }
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
    if (widget.customFocusNode == null) node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, node);
}
