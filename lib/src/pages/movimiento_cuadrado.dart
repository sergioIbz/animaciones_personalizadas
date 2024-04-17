import 'package:animaciones_personalizadas/src/pages/animaciones_page.dart';
import 'package:flutter/material.dart';

class MovimientoCuadrado extends StatefulWidget {
  const MovimientoCuadrado({super.key});

  @override
  State<MovimientoCuadrado> createState() => _MovimientoCuadradoState();
}

class _MovimientoCuadradoState extends State<MovimientoCuadrado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationDerecha;
  late Animation<double> animationArriba;
  late Animation<double> animationIzquierda;
  late Animation<double> animationAbajo;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );

    animationDerecha = Tween(
      begin: 0.0,
      end: 150.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25),
      ),
    );

    animationArriba = Tween(
      begin: 0.0,
      end: -150.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.50),
      ),
    );

    animationIzquierda = Tween(
      begin: 0.0,
      end: 150.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.50, 0.75),
      ),
    );

    animationAbajo = Tween(
      begin: 0.0,
      end: -150.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0),
      ),
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
    controller.repeat();

    return AnimatedBuilder(
      animation: animationDerecha,
      child: const Rectangle(),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
            offset: Offset(
              animationDerecha.value-animationIzquierda.value,
              animationArriba.value-animationAbajo.value,
            ),
            child: child!);
      },
    );
  }
}
