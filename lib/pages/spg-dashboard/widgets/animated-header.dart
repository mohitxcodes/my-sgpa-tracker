import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedHeader extends StatefulWidget {
  final Widget child;
  final double? height;

  const AnimatedHeader({
    super.key,
    required this.child,
    this.height,
  });

  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _colorController;
  List<List<Color>> gradientSets = [
    [Color(0xffFF5F6D), Color(0xffFFC371)],
  ];
  int currentGradientIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Auto change gradient every 15 seconds
    Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted) {
        _changeGradient();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _changeGradient() {
    setState(() {
      currentGradientIndex = (currentGradientIndex + 1) % gradientSets.length;
      _colorController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _colorController]),
      builder: (context, child) {
        final currentColors = gradientSets[currentGradientIndex];
        final nextColors =
            gradientSets[(currentGradientIndex + 1) % gradientSets.length];

        return Container(
          height: widget.height ?? 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(currentColors[0], nextColors[0],
                        _colorController.value) ??
                    currentColors[0],
                Color.lerp(currentColors[1], nextColors[1],
                        _colorController.value) ??
                    currentColors[1],
              ],
              begin: Alignment(
                cos(_controller.value * 2 * pi) * 1.5,
                sin(_controller.value * 2 * pi) * 1.5,
              ),
              end: Alignment(
                cos((_controller.value + 0.5) * 2 * pi) * 1.5,
                sin((_controller.value + 0.5) * 2 * pi) * 1.5,
              ),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
