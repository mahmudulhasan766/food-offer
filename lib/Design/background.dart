import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodoffer/Color_me/Color_me.dart';

class Homepagebackground extends StatelessWidget {

  final screenHeight;

  const Homepagebackground({Key key, @required this.screenHeight}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final themeData  = Theme.of(context);

    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.5,
        color: Color_me.back,
        margin: EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 0.0),
      ),
    );
  }
}
class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0,size.height*.50);
    Offset curveEndPoint = Offset(size.width,size.height*.50);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(size.width/2, size.height, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

