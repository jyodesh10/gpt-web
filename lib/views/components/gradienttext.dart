
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(this.text, {
    super.key,
    required this.gradient,
    this.style = const TextStyle(),
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    // Get exact size of the text view
    final TextPainter painter = TextPainter(text: TextSpan(text: text, style: style), textDirection: TextDirection.rtl);
    // Call layout method so width and height of this text widget get measured
    painter.layout();

    return CustomPaint(
      size: painter.size,
      painter: _GradientTextPainter(
        text: text,
        style: style,
        gradient: gradient
      ),
    );
  }
}

class _GradientTextPainter extends CustomPainter {
  final Gradient gradient;
  final String text;
  final TextStyle style;

  _GradientTextPainter({
    required this.text,
    required this.style,
    required this.gradient
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gradientShaderPaint = Paint()..shader = gradient.createShader(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height)
    );

    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle())
      ..pushStyle(ui.TextStyle(
        foreground: gradientShaderPaint,

        fontSize: style.fontSize,
        fontWeight: style.fontWeight,
        height: style.height,
        decoration: style.decoration,
        decorationColor: style.decorationColor,
        decorationStyle: style.decorationStyle,
        fontStyle: style.fontStyle,
        letterSpacing: style.letterSpacing,
        fontFamily: style.fontFamily,
        locale: style.locale,
        textBaseline: style.textBaseline,
        wordSpacing: style.wordSpacing,
      ))
      ..addText(text);

    final ui.Paragraph paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: size.width));

    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(_GradientTextPainter oldDelegate) {
    return gradient != oldDelegate.gradient ||
      text != oldDelegate.text ||
      style != oldDelegate.style;
  }
}