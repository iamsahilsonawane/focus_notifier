library focus_notifier;

export './focus_notification.dart';

import 'package:flutter/material.dart';
import 'focus_notification.dart';

typedef FocusNotifierBuilder = Widget Function(
    BuildContext context, FocusNode focusNode);

///Wrap this widget over a focus widget.
///Assign the focus node to the child focus widget
///
///Use [key] to add custom key for referencing it in the listener.
///
///If [FocusNotifier.customFocusNode] is used the custom focus node provided will not be disposed.
class FocusNotifier extends StatefulWidget {
  const FocusNotifier({Key? key, required this.builder}) : focusNode = null, super(key: key);
  const FocusNotifier.customFocusNode({Key? key, required this.builder, required this.focusNode}) : super(key: key);

  final FocusNotifierBuilder builder;
  final FocusNode? focusNode;

  @override
  State<FocusNotifier> createState() => _FocusNotifierState();
}

class _FocusNotifierState extends State<FocusNotifier> {
  FocusNode node = FocusNode();

  @override
  initState() {
    if (widget.focusNode != null) {
      node = widget.focusNode;
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
    if (widget.focusNode == null) node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, node);
}
