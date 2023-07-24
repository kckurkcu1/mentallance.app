import 'package:flutter/material.dart';
import 'dart:ui';





class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {super.key,
      
      required this.theWidth,
      required this.theHeight,
      required this.theChild});
  final double theWidth;
  final double theHeight;
  final Widget theChild;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all( Radius.circular(60)),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: Colors.transparent,
        child: Stack(children: [
          //*blur effect
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 1,
              sigmaY: 1,
            ),
            child: Container(),
          ),
          //*gradient effect
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [

                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.015),
                
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          //*child
          theChild
        ]),
      ),
    );
  }
}
