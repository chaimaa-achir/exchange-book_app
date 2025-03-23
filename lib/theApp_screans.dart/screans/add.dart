// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';

class Addbookscrean extends StatefulWidget {
  const Addbookscrean({super.key});

  @override
  State<Addbookscrean> createState() => _AddbookscreanState();
}

File? bookImage;
String? title;
String? author;
String? description;
bool imageError = false;
String? selectedOption;
String? tempSelectedOption;

final _formkey = GlobalKey<FormState>();

class _AddbookscreanState extends State<Addbookscrean> {
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      setState(() {
        bookImage = File(pickedFile.path);
        selectedOption = tempSelectedOption;
      });
    }
  }

  void _submitForm() {
  if (!_formkey.currentState!.validate()) return;

  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Book submitted successfully!'),
      backgroundColor: Colors.green,
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add"),
            elevation: 15,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.075,
                          top: MediaQuery.of(context).size.width * 0.05),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: DottedBorder(
                              color: imageError
                                  ? Colors.red
                                  : Colors.grey, // Border color
                              strokeWidth: 2, // Border thickness
                              dashPattern: [4, 2], // Dash length and space
                              borderType: BorderType.RRect,
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.099,
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(),
                                  child: bookImage != null &&
                                          bookImage!.existsSync()
                                      ? Image.file(bookImage!, fit: BoxFit.cover)
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Icon(Icons.camera_alt,
                                                    size: 40,
                                                    color: imageError
                                                        ? Colors.red
                                                        : Colors.grey),
                                                Positioned(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.001,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.004,
                                                  child: Container(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.025,
                                                    decoration: BoxDecoration(
                                                      color: imageError
                                                          ? Colors.red
                                                          : Color.fromARGB(
                                                              255, 160, 107, 186),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: MediaQuery.of(context)
                                                              .size
                                                              .height *
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
                            width: MediaQuery.of(context).size.width * 0.07,
                          ),
                          Text(
                            "Add a book image",
                            style: TextStyle(
                                color: imageError ? Colors.red : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    if (imageError)
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.035,
                            top: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          "book image is required!",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.025,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(context).size.width *
                                                  0.003,
                                          vertical:
                                              MediaQuery.of(context).size.width *
                                                  0.03),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Title is required!";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => title = value,
                                  ),
                                ),
                              ],
                            ),
                          ),
      
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
      
                          // Author Input
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Ensures left alignment
                              children: [
                                Text(
                                  "Author",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.025,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(context).size.width *
                                                  0.003,
                                          vertical:
                                              MediaQuery.of(context).size.width *
                                                  0.03),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Author is required!";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => author = value,
                                  ),
                                ),
                              ],
                            ),
                          ),
      
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
      
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description (optional)",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.025,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.grey,
                                      )),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(context).size.width *
                                                  0.003,
                                          vertical:
                                              MediaQuery.of(context).size.width *
                                                  0.03),
                                    ),
                                    onSaved: (value) => description = value,
                                  ),
                                )
                              ],
                            ),
                          ),
      
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Text(
                                "Select post type ",
                                style: TextStyle(fontSize: 15),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 160, 107, 186)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * 0.03,
                                    vertical: MediaQuery.of(context).size.height *
                                        0.002,
                                  )),
                              value: selectedOption,
                              hint: Text("Choose an option"),
                              items: ["For Sale", "Exchange", "Lending"]
                                  .map((String option) => DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                tempSelectedOption = value;
                              },
                              validator: (value) => value == null
                                  ? "Please select an option"
                                  : null,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Text(
                                "Book price (if the book for sale) ",
                                style: TextStyle(fontSize: 15),
                              )),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                ),
                                validator: (value) {
                                  if (selectedOption == "For Sale" &&
                                      (value == null || value.trim().isEmpty)) {
                                    return "Price is required for sale!";
                                  }
                                  if (value != null && value.isNotEmpty) {
                                    final num? price = num.tryParse(value);
                                    if (price == null || price <= 0) {
                                      return "Enter a valid price!";
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  if (selectedOption == "For Sale") {
                                    // Save the price
                                  }
                                },
                              ),
                            ),
                          ),
      
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Text("Your location (approx)")),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.29,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: CurrentUserLocation(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                                setState(() {
                                  imageError = bookImage == null;
                                  if (_formkey.currentState!.validate()) {
                                    if (!imageError) {
                                      _formkey.currentState!.save();
                                    }
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    255, 160, 107, 186), // Button color
                                padding: EdgeInsets.all(8), // Padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25), // Rounded corners
                                ),
                                elevation: 8, // Shadow effect
                                shadowColor: Colors.deepPurple
                                    .withOpacity(0.9), // Shadow color
                              ),
                              child: Text(
                                "Sumbit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
