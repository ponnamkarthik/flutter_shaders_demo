import 'package:flutter/material.dart';
import 'package:flutter_shaders_demo/particle_neon_shader.dart';
import 'package:flutter_shaders_demo/sample_shader.dart';
import 'package:flutter_shaders_demo/simple_color_shader.dart';
import 'package:flutter_shaders_demo/simple_colormap_shader.dart';
import 'package:flutter_shaders_demo/simple_shader.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SampleShaderPage(),
                ),
              );
            },
            child: const Text('Sample Shader'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SimpleShaderPage(),
                ),
              );
            },
            child: const Text('Simple Shader'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SimpleColorShaderPage(),
                ),
              );
            },
            child: const Text('Simple Color Shader'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SimpleColorMapShaderPage(),
                ),
              );
            },
            child: const Text('Simple ColorMap Shader'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ParticleNeonShaderPage(),
                ),
              );
            },
            child: const Text('Particle Neon Shader'),
          ),
        ],
      ),
    ));
  }
}
