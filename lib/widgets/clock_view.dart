import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;
  const ClockView({Key? key, required this.size,}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }
}


class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  //for seconds 60s = one rotation, 1s = 360/60 = 6
  //for minutes 60m = one rotation, 1m = 360/60 = 6
  //for hours 12h = one rotation, 1hr = 360/12 = 30

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width * 0.5; //center point along the x-axis
    var centerY = size.height * 0.5; //center point along the y axis
    var center = Offset(centerX,
        centerY); //exact center point on the canvas. remember that the top left corner is point (0,0) on the canvas
    var radius = min(centerX,
        centerY); //the minimum value between the center-points to ensure that the radius is contained within the shape on both axis

    var fillBrush = Paint()
      ..color = const Color(
          0xFF444974); //the inner paint object. In this case, it's a solid block of color
    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          16; //another paint object to be drawn for the outline of the clock. in this case, a stroke of width 16, basically a line of width 16
    var centerBrush = Paint()
      ..color = const Color(
          0xFFEAECFF); //you may have realized that the default is a filled object

    var secHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/60;
    var minHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        Color(0xFF748EF6),
        Color(0xFF77DDFF)
      ]).createShader(
          Rect.fromCircle(center: center, radius: radius)) //a shader babay!!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/30;

    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/24;

    canvas.drawCircle(center, radius * 0.75,
        fillBrush); //finally drawing the object on the canvas
    canvas.drawCircle(
        center, radius * 0.75, outlineBrush); //painting the outline of the clock

    var hourHandX = centerX +
        radius * 0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        radius * 0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerY + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
    canvas.drawCircle(
        center, radius * 0.12, centerBrush); //painting the center of the clock
    var dashBrush = Paint()..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for(int i=0;i<360;i+=12){
      var x1 = centerX + outerCircleRadius * cos(i * pi/180); //point at which dash begins on x axis
      var y1 = centerY + outerCircleRadius * sin(i * pi/180); //point at which dash begins on y axis

      var x2 = centerX + innerCircleRadius * cos(i * pi/180); //point at which dash ends on x axis
      var y2 = centerY + innerCircleRadius * sin(i * pi/180); //point at which dash ends on y axis
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; //rebuild any instances when setState() is invoked.
  }
}
