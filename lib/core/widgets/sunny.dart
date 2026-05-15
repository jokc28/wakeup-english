import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SunnyExpression { smile, wink, sad, sleepy, excited }

extension SunnyExpressionAsset on SunnyExpression {
  String get assetPath => 'assets/mascot/sunny-$name.svg';
}

/// Renders the Sunny mascot SVG at a given size. Stateless, pure — wrap in
/// an animation widget if motion is needed.
class Sunny extends StatelessWidget {
  const Sunny({
    super.key,
    required this.expression,
    this.size = 64,
    this.semanticLabel,
  });

  final SunnyExpression expression;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      expression.assetPath,
      key: Key('sunny-${expression.name}'),
      width: size,
      height: size,
      semanticsLabel: semanticLabel ?? 'Sunny ${expression.name}',
    );
  }
}
