import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
      final screenHeight =MediaQuery.of(context).size.height;
    final screenWidth =  MediaQuery.of(context).size.width;
    return Container(
      color: const Color.fromARGB(255, 253, 247, 242),
      child: SvgPicture.asset(
      "assets/img/page4.svg",
        height: screenHeight*0.99,
        width:  screenWidth*0.99,
                ),
    );
  }
}
