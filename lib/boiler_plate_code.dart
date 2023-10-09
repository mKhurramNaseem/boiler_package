library boiler_plate_code;

import 'package:boiler_plate_code/thermometer_widget.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Thermometer(width: widget.width * 0.2, height: widget.height * 0.8);
  }
}
