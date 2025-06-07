import 'package:flutter/material.dart';

double colorOnTap = 0;

class EffectTapContainer extends StatefulWidget {
  const EffectTapContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  EffectTapContainerState createState() => EffectTapContainerState();
}

class EffectTapContainerState extends State<EffectTapContainer>
    with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 100;
  // ignore: unused_field
  double _scaleTransformValue = 1;

  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() => _scaleTransformValue = 1 - animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();

    colorOnTap = 0.2;
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
    colorOnTap = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        _shrinkButtonSize();
      },
      onPanCancel: () {
        // ini masih ada gunanya
        _restoreButtonSize();
      },
      onPanEnd: (_) {
        // ini masih ada gunanya
        _restoreButtonSize();
      },
      onTapCancel: _restoreButtonSize, // ini kemungkinan ada sih
      child: AnimatedContainer(
        width: double.infinity,
        color: Colors.grey.withValues(alpha:  colorOnTap),
        duration: const Duration(milliseconds: 150),
        curve: Curves.fastOutSlowIn,
        child: widget.child,
      ),
    );
  }
}