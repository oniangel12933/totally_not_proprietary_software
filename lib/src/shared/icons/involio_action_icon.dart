import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:insidersapp/src/theme/colors.dart';

Widget getInvolioActionButtonIcon(BuildContext context) {
  const double size = 30.0;
  return SizedBox(
    width: size,
    height: size,
    child: Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: AppColors.involioBlue,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: size / 2, bottom: size / 2),
          width: 15.0,
          child: const QuarterCircle(
            color: AppColors.involioBrightBlue,
            circleAlignment: CircleAlignment.bottomLeft,
          ),
        ),
        Center(
          child: Icon(context.involioIcons.plus, color: Colors.white),
        ),
      ],
    ),
  );
}

enum CircleAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// https://stackoverflow.com/questions/51690562/quarter-circle-shape-with-a-container-in-flutter
class QuarterCircle extends StatelessWidget {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCircle({
    this.color = Colors.grey,
    this.circleAlignment = CircleAlignment.topLeft,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRect(
        child: CustomPaint(
          painter: QuarterCirclePainter(
            circleAlignment: circleAlignment,
            color: color,
          ),
        ),
      ),
    );
  }
}

class QuarterCirclePainter extends CustomPainter {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCirclePainter({
    required this.circleAlignment,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width);
    final offset = circleAlignment == CircleAlignment.topLeft
        ? const Offset(.0, .0)
        : circleAlignment == CircleAlignment.topRight
        ? Offset(size.width, .0)
        : circleAlignment == CircleAlignment.bottomLeft
        ? Offset(.0, size.height)
        : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }
}
