import 'package:boiler_plate_code/thermometer_painter.dart';
import 'package:flutter/material.dart';

class Thermometer extends StatefulWidget {
  final double width;
  final double height;
  final double topPosition;
  const Thermometer({
    super.key,
    required this.width,
    required this.height,
    this.topPosition = 0.1,
  });

  @override
  State<Thermometer> createState() => _ThermometerState();
}

class _ThermometerState extends State<Thermometer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: ThermometerPainter(topPosition: widget.topPosition),
      ),
    );
  }
}
