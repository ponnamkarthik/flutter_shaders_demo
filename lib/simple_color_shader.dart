import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class SimpleColorShaderPage extends StatefulWidget {
  const SimpleColorShaderPage({super.key});

  @override
  State<SimpleColorShaderPage> createState() => _SimpleColorShaderPageState();
}

class _SimpleColorShaderPageState extends State<SimpleColorShaderPage> {
  late Timer timer;
  double delta = 0;

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        delta += 0.02;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Shader Demo'),
      ),
      body: ShaderBuilder(
        assetKey: 'shaders/color.frag',
            (context, shader, child) => CustomPaint(
          size: MediaQuery.of(context).size,
          painter: ColorShaderPainter(
            shader: shader,
            uniforms: [delta],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


class ColorShaderPainter extends CustomPainter {
  ColorShaderPainter({required this.shader, required this.uniforms});
  ui.FragmentShader shader;
  final List<double> uniforms;


  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    for (int i = 0; i < uniforms.length; i++) {
      var value = uniforms[i];
      shader.setFloat(i + 2, value);
    }

    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}