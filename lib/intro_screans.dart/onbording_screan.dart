import 'package:flutter/material.dart';
import 'package:mini_project/Authentication_sreans.dart/signupscrean.dart';
import 'package:mini_project/intro_screans.dart/intro_Page1.dart';
import 'package:mini_project/intro_screans.dart/intro_Page2.dart';
import 'package:mini_project/intro_screans.dart/intro_Page3.dart';
import 'package:mini_project/intro_screans.dart/intro_Page4.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnbordingScrean extends StatefulWidget {
  const OnbordingScrean({super.key});

  @override
  State<OnbordingScrean> createState() => _OnBordingscreanState();
}

class _OnBordingscreanState extends State<OnbordingScrean> {

 final  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
            ],
          ),
          onLastPage
              ? Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.070,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscrean()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 160, 107, 186),
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  "Let's get start",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: Icon(Icons.arrow_right_alt_outlined,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(3);
                          },
                          child: Text("skip"),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 70),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SmoothPageIndicator(
                              controller: _controller,
                              count: 3,
                              effect: JumpingDotEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                jumpScale: 8,
                                activeDotColor:
                                    Color.fromARGB(255, 160, 107, 186),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Color.fromARGB(255, 160, 107, 186),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
