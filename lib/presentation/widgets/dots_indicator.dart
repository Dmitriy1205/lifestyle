import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifestyle/common/constants/colors.dart';

typedef OnTap = void Function(double position);

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final double position;
  final DotsDecorator decorator;
  final Axis axis;
  final bool reversed;
  final OnTap? onTap;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  DotsIndicator({
    Key? key,
    required this.dotsCount,
    this.position = 0.0,
    this.decorator = const DotsDecorator(),
    this.axis = Axis.horizontal,
    this.reversed = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onTap,
  })  : assert(dotsCount > 0, 'dotsCount must be superior to zero'),
        assert(position >= 0, 'position must be superior or equals to zero'),
        assert(
          position < dotsCount,
          "position must be less than dotsCount",
        ),
        assert(
          decorator.colors.isEmpty || decorator.colors.length == dotsCount,
          "colors param in decorator must empty or have same length as dotsCount parameter",
        ),
        assert(
          decorator.activeColors.isEmpty ||
              decorator.activeColors.length == dotsCount,
          "activeColors param in decorator must empty or have same length as dotsCount parameter",
        ),
        assert(
          decorator.sizes.isEmpty || decorator.sizes.length == dotsCount,
          "sizes param in decorator must empty or have same length as dotsCount parameter",
        ),
        assert(
          decorator.activeSizes.isEmpty ||
              decorator.activeSizes.length == dotsCount,
          "activeSizes param in decorator must empty or have same length as dotsCount parameter",
        ),
        assert(
          decorator.shapes.isEmpty || decorator.shapes.length == dotsCount,
          "shapes param in decorator must empty or have same length as dotsCount parameter",
        ),
        assert(
          decorator.activeShapes.isEmpty ||
              decorator.activeShapes.length == dotsCount,
          "activeShapes param in decorator must empty or have same length as dotsCount parameter",
        ),
        super(key: key);

  Widget _wrapInkwell(Widget dot, int index) {
    return InkWell(
      customBorder: position == index
          ? decorator.getActiveShape(index)
          : decorator.getShape(index),
      onTap: () => onTap!(index.toDouble()),
      child: dot,
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    final lerpValue = min(1.0, (position - index).abs());

    final size = Size.lerp(
      decorator.getActiveSize(index),
      decorator.getSize(index),
      lerpValue,
    )!;

    final dot = Container(
      width: size.width,
      height: size.height,
      margin: decorator.spacing,
      decoration: ShapeDecoration(
        color: Color.lerp(
          decorator.getActiveColor(index) ?? Theme.of(context).primaryColor,
          decorator.getColor(index),
          lerpValue,
        ),
        shape: ShapeBorder.lerp(
          decorator.getActiveShape(index),
          decorator.getShape(index),
          lerpValue,
        )!,
      ),
    );
    return onTap == null ? dot : _wrapInkwell(dot, index);
  }

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(
      dotsCount,
      (i) => _buildDot(context, i),
    );
    final dots = reversed ? dotsList.reversed.toList() : dotsList;

    return axis == Axis.vertical
        ? Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: dots,
          )
        : Row(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: dots,
          );
  }
}

const Size kDefaultSize = Size.square(9.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  final Color color;

  final List<Color> colors;

  final Color? activeColor;

  final List<Color> activeColors;

  final Size size;

  final List<Size> sizes;

  final Size activeSize;

  final List<Size> activeSizes;

  final ShapeBorder shape;

  final List<ShapeBorder> shapes;

  final ShapeBorder activeShape;

  final List<ShapeBorder> activeShapes;

  final EdgeInsets spacing;

  const DotsDecorator({
    this.color = AppColors.active,
    this.colors = const [],
    this.activeColor = AppColors.contrast,
    this.activeColors = const [],
    this.size = kDefaultSize,
    this.sizes = const [],
    this.activeSize = kDefaultSize,
    this.activeSizes = const [],
    this.shape = kDefaultShape,
    this.shapes = const [],
    this.activeShape = kDefaultShape,
    this.activeShapes = const [],
    this.spacing = kDefaultSpacing,
  });

  Color? getActiveColor(int index) {
    return activeColors.isNotEmpty ? activeColors[index] : activeColor;
  }

  Color getColor(int index) {
    return colors.isNotEmpty ? colors[index] : color;
  }

  Size getActiveSize(int index) {
    return activeSizes.isNotEmpty ? activeSizes[index] : activeSize;
  }

  Size getSize(int index) {
    return sizes.isNotEmpty ? sizes[index] : size;
  }

  ShapeBorder getActiveShape(int index) {
    return activeShapes.isNotEmpty ? activeShapes[index] : activeShape;
  }

  ShapeBorder getShape(int index) {
    return shapes.isNotEmpty ? shapes[index] : shape;
  }
}
