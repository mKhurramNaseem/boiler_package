library boiler_plate_code;

import 'package:boiler_plate_code/thermometer_widget.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Thermometer(width: width * 0.2, height: height * 0.8);
  }
}
