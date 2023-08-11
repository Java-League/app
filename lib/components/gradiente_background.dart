import 'package:flutter/material.dart';

class GradientBrackground extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final BoxShape shape;
  const GradientBrackground({this.shape = BoxShape.rectangle, this.child, this.width, this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: shape,
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).colorScheme.primaryContainer,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
