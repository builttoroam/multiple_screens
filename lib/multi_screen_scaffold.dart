import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

/// A widget similar to Scaffold which supports multi screens
class MultiScreenScaffold extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final bool appSpanned;
  final Color backgroundColor;
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final Widget drawer;
  final DragStartBehavior drawerDragStartBehavior;
  final double drawerEdgeDragWidth;
  final Color drawerScrimColor;
  final Widget endDrawer;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget floatingActionButton;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget left;
  final List<Widget> persistentFooterButtons;
  final bool primary;
  final bool resizeToAvoidBottomInset;
  final Widget right;

  const MultiScreenScaffold({
    Key key,
    this.appBar,
    this.appSpanned,
    this.backgroundColor,
    this.body,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerScrimColor,
    this.endDrawer,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.left,
    this.persistentFooterButtons,
    this.primary = true,
    this.resizeToAvoidBottomInset,
    this.right,
  })  : assert(appSpanned != null),
        assert(
          (left != null && right != null && body == null) ||
              (left == null && right == null && body != null),
        ),
        super(key: key);

  @override
  _MultiScreenScaffoldState createState() => _MultiScreenScaffoldState();
}

class _MultiScreenScaffoldState extends State<MultiScreenScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      drawer: widget.drawer,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerScrimColor: widget.drawerScrimColor,
      endDrawer: widget.endDrawer,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      persistentFooterButtons: widget.persistentFooterButtons,
      primary: widget.primary,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: widget.body != null
          ? widget.body
          : widget.appSpanned
              ? Row(
                  children: [
                    Expanded(flex: 1, child: widget.left),
                    SizedBox(width: Constants.hingeWidth),
                    Expanded(flex: 1, child: widget.right),
                  ],
                )
              : widget.left,
    );
  }
}
