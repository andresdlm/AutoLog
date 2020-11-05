import 'package:flutter/material.dart';

class CurvedWidget extends StatelessWidget{
  final Widget child;
  final double curvedDistance;
  final double curvedHeight;

  const CurvedWidget({Key key, this.curvedDistance = 80, this.curvedHeight = 80, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context){
    return ClipPath(
      clipper: CurvedWidgetBackgroundClipper(
        curvedDistance: curvedDistance,
        curvedHeigth: curvedHeight,
      ),
      child: child,
    );
  }
}

class CurvedWidgetBackgroundClipper extends CustomClipper<Path> {
  final double curvedDistance;
  final double curvedHeigth;

  CurvedWidgetBackgroundClipper({this.curvedDistance, this.curvedHeigth});

  @override
  getClip(Size size) { //bode arriba
    Path clippedPath = Path();
    clippedPath.lineTo(size.width, 0);
    clippedPath.lineTo(size.width, size.height - curvedDistance - curvedHeigth);
    clippedPath.quadraticBezierTo(size.width, size.height - curvedHeigth, size.width - curvedDistance, size.height -curvedHeigth);
    clippedPath.lineTo(curvedDistance, size.height - curvedHeigth);
    clippedPath.quadraticBezierTo(0, size.height - curvedHeigth, 0, size.height);
    clippedPath.lineTo(0, 0);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }

}