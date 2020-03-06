import 'package:flutter/widgets.dart';

class SwipeDetector extends StatefulWidget {
  final dynamic child;
  final Function onSwipeRight;
  final Function onSwipeDown;
  final Function onSwipeLeft;
  final Function onSwipeUp;

  SwipeDetector({
    this.onSwipeRight,
    this.onSwipeLeft,
    this.onSwipeDown,
    this.onSwipeUp,
    this.child,
  });

  @override
  State<StatefulWidget> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  // Vertical drag details
  DragStartDetails _startVerticalDragDetails;
  DragUpdateDetails _updateVerticalDragDetails;

  // Horizontal drag detailes
  DragStartDetails _startHorizontalDragDetails;
  DragUpdateDetails _updateHorizontalDragDetails;

  _verticalEndAction(BuildContext ctx, endDetails) {
    double dx = _updateVerticalDragDetails.globalPosition.dx -
        _startVerticalDragDetails.globalPosition.dx;
    double dy = _updateVerticalDragDetails.globalPosition.dy -
        _startVerticalDragDetails.globalPosition.dy;
    double velocity = endDetails.primaryVelocity;

    //Convert values to be positive
    if (dx < 0) dx = -dx;
    if (dy < 0) dy = -dy;

    if (velocity < 0) {
      if (widget.onSwipeUp != null) widget.onSwipeUp();
    } else {
      if (widget.onSwipeDown != null) widget.onSwipeDown();
    }
  }

  _horizontalEndAction(BuildContext ctx, endDetails) {
    double dx = _updateHorizontalDragDetails.globalPosition.dx -
        _startHorizontalDragDetails.globalPosition.dx;
    double dy = _updateHorizontalDragDetails.globalPosition.dy -
        _startHorizontalDragDetails.globalPosition.dy;
    double velocity = endDetails.primaryVelocity;

    //Convert values to be positive
    if (dx < 0) dx = -dx;
    if (dy < 0) dy = -dy;

    if (velocity < 0) {
      if (widget.onSwipeRight != null) widget.onSwipeRight();
    } else {
      if (widget.onSwipeLeft != null) widget.onSwipeLeft();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onVerticalDragStart: (dragDetails) {
        _startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        _updateVerticalDragDetails = dragDetails;
      },
      onHorizontalDragStart: (dragDetails) {
        _startHorizontalDragDetails = dragDetails;
      },
      onHorizontalDragUpdate: (dragDetails) {
        _updateHorizontalDragDetails = dragDetails;
      },
      onVerticalDragEnd: (endDetails) {
        _verticalEndAction(context, endDetails);
      },
      onHorizontalDragEnd: (endDetails) {
        _horizontalEndAction(context, endDetails);
      },
    );
  }
}
