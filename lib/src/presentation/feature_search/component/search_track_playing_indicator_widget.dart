import 'package:flutter/material.dart';

class TrackPlayingIndicatorWidget extends StatefulWidget {
  final Color color;

  final Duration duration;

  const TrackPlayingIndicatorWidget(
    this.color,
    this.duration, {
    Key? key,
  }) : super(key: key);

  @override
  State<TrackPlayingIndicatorWidget> createState() {
    return _TrackPlayingIndicatorWidgetState();
  }
}

class _TrackPlayingIndicatorWidgetState
    extends State<TrackPlayingIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCubic,
      ),
    )..addListener(_animationListener);
    animationController.repeat(reverse: true);
  }

  void _animationListener() {
    setState(() {});
  }

  @override
  void dispose() {
    animation.removeListener(_animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: animation.value / 2,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
