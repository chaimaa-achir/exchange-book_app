import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';



class ImagePalceholder extends StatelessWidget {
  final bool imageError;
  final File? bookImage;
  final VoidCallback pickImages;
  final bool showErrorMessage;
  const ImagePalceholder(
      {super.key,
      required this.imageError,
      required this.bookImage,
      required this.pickImages,
      this.showErrorMessage=true,
      });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => pickImages(),
            child: DottedBorder(
              color:(showErrorMessage && imageError) ? Colors.red : Colors.grey, // Border color
              strokeWidth: 2, // Border thickness
              dashPattern: [4, 2], // Dash length and space
              borderType: BorderType.RRect,
              child: Container(
                  height:screenHeight * 0.099,
                  width:screenWidth* 0.25,
                  decoration: BoxDecoration(),
                  child: bookImage != null && bookImage!.existsSync()
                      ? Image.file(bookImage!, fit: BoxFit.cover)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Icon(Icons.camera_alt,
                                    size: 40,
                                    color:
                                        (showErrorMessage && imageError) ? Colors.red : Colors.grey),
                                Positioned(
                                  bottom:
                                     screenWidth* 0.001,
                                  right:
                                     screenWidth* 0.004,
                                  child: Container(
                                    height:screenHeight *
                                        0.025,
                                    decoration: BoxDecoration(
                                      color: imageError
                                          ? Colors.red
                                          : Color.fromARGB(255, 160, 107, 186),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size:screenHeight *
                                          0.019,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
            ),
          ),
          SizedBox(
            width:screenWidth* 0.08,
          ),
        if(showErrorMessage)
            Text(
            imageError
                ? "Please book image  is required"
                : "Add book cover image",
            style: TextStyle(
              color: imageError ? Colors.red : Colors.grey,
            ),
          ),
        if(!showErrorMessage)
        Text("add Images to share",style: TextStyle(color:Colors.grey),),
        ],
      ),
    );
  }
}
