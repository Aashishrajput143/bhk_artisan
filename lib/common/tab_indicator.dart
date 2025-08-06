import 'package:bhk_artisan/common/gradient.dart';
import 'package:flutter/material.dart';

class TabIndicators extends StatelessWidget {
  final int _numTabs;
  final int _activeIdx;
  final Color _activeColor;
  final Color _inactiveColor;
  final double _padding;
  final double _height;
  final void Function(int) onTap;

  const TabIndicators({required int numTabs, required int activeIdx, required Color activeColor, required double padding, required double height, Color inactiveColor = const Color(0x00FFFFFF), required this.onTap, super.key})
      : _numTabs = numTabs,
        _activeIdx = activeIdx,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _padding = padding,
        _height = height;

  @override
  Widget build(BuildContext context) {
    final elements = <Widget>[];

    for (var i = 0; i < _numTabs; ++i) {
      elements.add(Expanded(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _padding,vertical: 0),
        child: Container(
          height: _height,
          decoration: BoxDecoration(
            gradient: i == _activeIdx ? AppGradients.tabGradient : null,
          ),
          child: InkWell(
            onTap: () => onTap(i),
            child: Align(
              alignment: Alignment.topCenter,
              child:CustomPaint(
                painter: NotchedTabPainter(i == _activeIdx ?_activeColor:Colors.transparent),child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _activeIdx ? _activeColor : _inactiveColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
          )));
    }

    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: elements,
      ),
    );
  }
}

class NotchedTabPainter extends CustomPainter {
  final Color color;

  NotchedTabPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill; // ✅ ensures filling

    final path = Path();

    // Top notch
    //const topPadding = 4.0;
    const notchWidth = 5.0;
    const notchDepth = 10.0;

    // Bottom triangle
    const triangleWidth = 18.0;
    const triangleHeight = 5.0;

    final centerX = size.width / 2;
    final leftNotch = centerX - notchWidth / 2;
    final rightNotch = centerX + notchWidth / 2;

    final triangleLeft = centerX - triangleWidth / 2;
    final triangleRight = centerX + triangleWidth / 2;
    final triangleTipY = size.height + triangleHeight;

    path.moveTo(0, 0);
    path.lineTo(leftNotch, 0);
    path.quadraticBezierTo(centerX, 0 + notchDepth, rightNotch, 0);
    path.lineTo(triangleRight, size.height);
    path.lineTo(centerX, triangleTipY); // Downward triangle tip
    path.lineTo(triangleLeft, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
