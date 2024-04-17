import 'dart:math';

import 'package:flutter/material.dart';

import '../pages/animaciones_page.dart';

class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    super.key,
  });

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> opacity;
  late Animation<double> opacityOut;
  late Animation<double> moveRight;
  bool isOpen = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 5000,
      ),
    );
    animation = Tween(
      begin: 0.0,
      end: 2.0 * pi,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.35,
          1.0,
          curve: Curves.easeInBack,
        ),
      ),
    );

    opacity = Tween(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.30),
      ),
    );

    opacityOut = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0),
      ),
    );

    moveRight = Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(
      controller,
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: const Rectangle(),
      builder: (BuildContext context, Widget? child) {
        if (controller.status == AnimationStatus.completed) {
          controller.reverse();
        } else if (controller.status == AnimationStatus.dismissed) {
          controller.repeat();
        }
        return Transform.translate(
          offset: Offset(
            moveRight.value,
            -moveRight.value,
          ),
          child: Transform.rotate(
            alignment: Alignment.center,
            angle: animation.value,
            child: Opacity(
              opacity: opacity.value- opacityOut.value,
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
