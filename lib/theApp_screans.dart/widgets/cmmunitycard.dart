import 'package:flutter/material.dart';
import 'package:mini_project/helpers/comment_utils.dart';
import 'package:mini_project/helpers/time_utils.dart';
import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';
import 'package:mini_project/theApp_screans.dart/screans/postdetails.dart';
import 'package:mini_project/theApp_screans.dart/widgets/report_dailog.dart';



class Communitycard extends StatefulWidget {
  final Community community;

  const Communitycard({
    super.key,
    required this.community,
  });
  @override
  State<Communitycard> createState() => _CommunitycardState();
}

class _CommunitycardState extends State<Communitycard> {
  double getTextHeight(String text, TextStyle style, double width) {
    TextSpan textSpan = TextSpan(text: text, style: style);
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: 7,
    )..layout(maxWidth: width);

    return textPainter.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    double textHeight = getTextHeight(
        widget.community.Forum, // here this will change from data base
        TextStyle(fontSize: 16),
        screenWidth * 0.8);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(0.02),
              child: GestureDetector(
                onTap: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Postdetails(community: widget.community)),
                  );
                  setState(() {});
                },
                child: Container(
                  height: widget.community.imagesCommunity.isEmpty
                      ? textHeight + screenHeight * 0.3
                      : screenHeight * 0.45,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 110, 109, 109),
                          offset: Offset(5, 7),
                          blurRadius: 10,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                showReportOptions(context, (selectedReason) {
                                // print("the reason:$selectedReason");
                  });
                              },
                              icon: Icon(
                                Icons.flag_outlined,
                                size: 30,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          CircleAvatar(
                            radius: 23,
                            backgroundImage: AssetImage(widget.community
                                .userimage), // i get it from data base
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.community.username,
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  Text(
                                    timeAgo(widget.community.Cpostdate),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ), // i will worck on this
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      SizedBox(
                        width: screenWidth * 0.8,
                        child: widget.community.imagesCommunity.isNotEmpty
                            ? Text(
                                widget.community.Forum,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                widget.community.Forum,
                                textAlign: TextAlign.start,
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                      if (widget.community.imagesCommunity.isNotEmpty) ...[
                        SizedBox(
                            height: screenHeight * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child:
                              buildPostImages(widget.community.imagesCommunity),
                        ),
                      ],
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(117, 158, 158, 158),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.question_answer_outlined),

                              Text(
                                "${countAllComments(widget.community.comments)} comments",
                              
                              ), // number changes
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.community.isLiked =
                                        !widget.community.isLiked;
                                    if (widget.community.isLiked) {
                                      widget.community.numberlikes++;
                                    } else {
                                      widget.community.numberlikes--;
                                    }
                                  });
                                },
                                child: Icon(
                                  widget.community.isLiked
                                      ? Icons.favorite
                                      : Icons
                                          .favorite_border, // Change the icon based on like state
                                  color: widget.community.isLiked ? Colors.red : Colors.black,
                                ),
                              ),
                              Text(
                                "${widget.community.numberlikes} likes",
                                
                              ), // number changes
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostImages(List<String> images) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    int count = images.length;
    if (count == 1) {
      return Column(
        children: [
          ClipRRect(
            child: Image.asset(
              images[0],
              fit: BoxFit.cover,
              width: screenWidth * 0.8,
              height: screenHeight * 0.18,
            ),
          ),
        ],
      );
    } else if (count == 2) {
      return Column(
        children: [
          Row(
            children: images
                .take(2)
                .map((img) => Expanded(child: imageTile(img)))
                .toList(),
          ),
        ],
      );
    }
    return SizedBox(
      width: screenWidth * 0.8,
      height: screenHeight * 0.18,
      child: Row(
        children: [
          // Left big image
          Container(
            width: screenWidth * 0.4,
            height: double.infinity,
            padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.003),
            child: imageTile2(images[0]),
          ),

          // Right 2 stacked images
          Expanded(
            child: Column(
              children: [
                // First top right image
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical:screenHeight *0.001 ),
                    child: imageTile2(images[1]),
                  ),
                ),

                // Second bottom right image inside a Stack
                if (count > 2)
                  Expanded(
                    child: Stack(
                      children: [
                        // The image behind
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: screenHeight *0.001),
                          child: imageTile2(images[2]),
                        ),
                        // The "+more" overlay
                        if (count > 3)
                          Container(
                            color: Colors.black54,
                            alignment: Alignment.center,
                            child: Text(
                              "+${count - 3}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageTile(String imgPath) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:screenWidth*0.003),
      child: ClipRRect(
        child: Image.asset(
          imgPath,
          fit: BoxFit.cover,
          width: screenWidth * 0.8,
          height: screenHeight * 0.18,
        ),
      ),
    );
  }

  Widget imageTile2(String imgPath) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:screenWidth*0.003),
      child: ClipRRect(
        child: Image.asset(
          imgPath,
          fit: BoxFit.cover,
          width: screenWidth * 0.8,
          height: screenHeight * 0.14,
        ),
      ),
    );
  }
}
