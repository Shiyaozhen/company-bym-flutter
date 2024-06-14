import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final List<Color> colors;

  const GradientCircularProgressIndicator({
    super.key,
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2 + 10,
      height: radius * 2 + 10,
      child: CustomPaint(
        painter: _GradientCircularProgressPainter(
          lineWidth: lineWidth,
          percent: percent,
          colors: colors,
        ),
        child: Center(
          child: Text(
            '${(percent * 100).toStringAsFixed(0)}%',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double lineWidth;
  final double percent;
  final List<Color> colors;
  final double startAngle;

  _GradientCircularProgressPainter({
    required this.lineWidth,
    required this.percent,
    required this.colors,
    this.startAngle = -pi / 2, // 设置起始角度为 -π/2，即从上方开始
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - lineWidth / 2,
    );

    final gradient = SweepGradient(
      colors: colors,
      startAngle: startAngle, // 使用起始角度
      endAngle: startAngle + 2 * pi * percent,
      tileMode: TileMode.clamp,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..shader = gradient.createShader(rect);

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..color = Colors.grey.withOpacity(0.2); // 使用灰色的背景颜色

    // 绘制背景圆环
    canvas.drawArc(rect, startAngle, 2 * pi, false, backgroundPaint);

    // 绘制圆环进度
    canvas.drawArc(rect, startAngle, 2 * pi * percent, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
