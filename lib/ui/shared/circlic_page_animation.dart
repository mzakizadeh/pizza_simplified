import 'dart:math';

import 'package:flutter/material.dart';

class CirclicPageAnimation extends StatefulWidget {
  const CirclicPageAnimation({
    Key key,
    @required this.controller,
    @required this.index,
    @required this.initialPage,
    @required this.child,
    this.maxRotate = 0.0,
    this.minScale = 0.7,
  }) : super(key: key);

  final Widget child;
  final double maxRotate;
  final double minScale;
  final PageController controller;
  final int index;
  final int initialPage;

  @override
  _CirclicPageAnimationState createState() => _CirclicPageAnimationState();
}

class _CirclicPageAnimationState extends State<CirclicPageAnimation> {
  double rotate = 0.0;
  double scale = 1.0;

  @override
  void initState() {
    widget.controller.addListener(_setAnimation);

    if (widget.index == widget.initialPage) {
      rotate = 0.0;
      scale = 1.0;
    } else {
      rotate = widget.maxRotate;
      scale = widget.minScale;
    }

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_setAnimation);
    super.dispose();
  }

  void _setAnimation() {
    setState(() {
      _updateRotate();
      _updateScale();
    });
  }

  _updateRotate() {
    double diff;

    if (widget.controller?.page != null) {
      diff = (widget.controller.page - widget.index).clamp(-1.0, 1.0);
    } else {
      diff = 1.0;
    }

    if (diff < 0) {
      rotate = Curves.ease.transform(-diff) * widget.maxRotate;
    } else {
      rotate = -Curves.ease.transform(diff) * widget.maxRotate;
    }
  }

  _updateScale() {
    double diff;

    if (widget.controller?.page != null) {
      diff = (widget.controller.page - widget.index).clamp(-1.0, 1.0);
    } else {
      diff = 1.0;
    }

    double absDiff = diff < 0 ? diff * -1 : diff;

    double _scale = 1.0 - (absDiff);

    scale = widget.minScale +
        (Curves.ease.transform(_scale) * (1.0 - widget.minScale));
  }

  @override
  Widget build(BuildContext context) {
    Offset origin;
    return LayoutBuilder(
      builder: (context, constraints) {
        double m = constraints.maxWidth;
        if (widget.controller.position.haveDimensions) {
          origin = widget.controller.page > widget.index
              ? Offset(.55 * m, .4 * m)
              : Offset(-.55 * m, .4 * m);
        } else {
          origin = widget.initialPage > widget.index
              ? Offset(.55 * m, .4 * m)
              : Offset(-.55 * m, .4 * m);
        }
        return Transform.scale(
          origin: origin,
          scale: scale,
          child: Column(
            children: [
              Transform.rotate(
                angle: rotate * pi / 180,
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}
