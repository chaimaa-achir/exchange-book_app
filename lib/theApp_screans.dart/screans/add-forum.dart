import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/widgets/image-placeholder.dart';



class AddForumScreen extends StatefulWidget {
  const AddForumScreen({super.key});

  @override
  State<AddForumScreen> createState() => _AddForumScreenState();
}

final TextEditingController _decriptioncontroller = TextEditingController();
File? forumImage;

class _AddForumScreenState extends State<AddForumScreen> {
  List<File> images = [];




Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        images.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  } 
  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  void _submitForm() {
    if (_decriptioncontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("To sumbit write a description"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Post submitted successfully!"),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Community Post"),
          elevation: 15,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height:  screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width:  screenWidth * 0.04,
                    ),
                    CircleAvatar(
                      radius: 21,
                      backgroundImage: AssetImage(
                          "assets/img/history.jpg"), // i get it from data base
                    ),
                    SizedBox(
                      width:  screenWidth * 0.04,
                    ),
                    Text(
                      " username",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ), // iget it from data base
                  ],
                ),
                Divider(),
                SizedBox(
                  height:  screenHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(
                        left:  screenWidth * 0.075,
                        top:  screenWidth * 0.05,
                      ),
                  child: images.isEmpty
                      ? ImagePalceholder(
                          imageError: false,
                          bookImage: forumImage,
                          pickImages:  _pickImages,
                          showErrorMessage: false,
                        )
                      : SizedBox(
                          height:  screenHeight * 0.13,
                          child: _buildImageGrid()),
                ),
                SizedBox(
                  height:  screenHeight * 0.05,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Text(
                            "🌍 Share relevant topics with the community",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextField(
                            controller: _decriptioncontroller,
                            decoration: InputDecoration(
                              hintText: "Type here ",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.grey,
                              )),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                       screenWidth *
                                          0.003,
                                  vertical:
                                       screenWidth *
                                          0.03),
                            )),
                      ),
                      SizedBox(
                        height:  screenHeight * 0.1,
                      ),
                       myelvatedbottom(
                        onPressed: _submitForm,
                        text: 'Sumbit',
                       ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length < 10 ? images.length + 1 : 10,
      itemBuilder: (context, index) {
        if (index == images.length && images.length < 10) {
          return _buildAddButton();
        }
        return _buildImageItem(index);
      },
    );
  }

  Widget _buildImageItem(int index) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width:  screenWidth * 0.25,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap:  _pickImages,
        child: DottedBorder(
          color: Colors.grey,
          strokeWidth: 2,
          dashPattern: [6, 3],
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          child: Container(
            height:  screenHeight * 0.2,
            width:  screenWidth * 0.25,
            child: Center(
              child: Icon(Icons.add, size: 40, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
