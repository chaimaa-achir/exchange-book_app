// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import 'dart:io';
//import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mini_project/shared/costumeTextfeaildForm.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/widgets/image-placeholder.dart';

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
List<File> bookImages = [];

class _AddbookscreanState extends State<Addbookscrean> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _authorcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  List<File> images = [];

  Future<void> _pickSingleImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        bookImage = File(pickedFile.path);
        imageError = false;
      });
    }
  }

  void _submitForm() {
    setState(() {
      // Ensure that imageError is true if no images are selected
      imageError = bookImage==null;
      selectedOption = tempSelectedOption;
    });

    if (!_formkey.currentState!.validate() || imageError) return;

    if (!imageError) {
      _formkey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Book submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _authorcontroller.dispose();
    _titlecontroller.dispose();
    _pricecontroller.dispose();
    _descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add"),
          elevation: 15,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.075,
                        top: screenWidth * 0.05,
                      ),
                      child: ImagePalceholder(
                        imageError: imageError,
                        bookImage: bookImage,
                        pickImages: _pickSingleImage,
                        showErrorMessage: true,
                      )),
                  SizedBox(
                    height: screenHeight * 0.05,
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
                              const Text(
                                "Title",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: screenHeight * 0.034,
                              ),
                              myTextfeaildForm(
                                controller: _titlecontroller,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Title is required!";
                                  }
                                  return null;
                                },
                                OnSaved: (value) => title = value,
                                heighFactor: 0.02,
                                WidthFactor: 0.9,
                                paddingHorizontalFactor: 0.003,
                                paddingVerticalFactor: 0.04,
                              ),
                            ],
                          ),
                        ),
    
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
    
                        // Author Input
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Ensures left alignment
                            children: [
                              const Text(
                                "Author",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: screenHeight * 0.034,
                              ),
                              myTextfeaildForm(
                                controller: _authorcontroller,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Author is required!";
                                  }
                                  return null;
                                },
                                OnSaved: (value) => author = value,
                                heighFactor: 0.02,
                                WidthFactor: 0.9,
                                paddingHorizontalFactor: 0.003,
                                paddingVerticalFactor: 0.04,
                              ),
                            ],
                          ),
                        ),
    
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
    
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description (optional)",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: screenHeight * 0.034,
                              ),
                              myTextfeaildForm(
                                controller: _descriptioncontroller,
                                OnSaved: (value) => description = value,
                                heighFactor: 0.02,
                                WidthFactor: 0.9,
                                paddingHorizontalFactor: 0.003,
                                paddingVerticalFactor: 0.04,
                              ),
                            ],
                          ),
                        ),
    
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        FractionallySizedBox(
                            widthFactor: 0.9,
                            child: const Text(
                              "Select post type ",
                              style: TextStyle(fontSize: 15),
                            )),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 160, 107, 186)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red)),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03,
                                  vertical: screenHeight * 0.002,
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
                          height: screenHeight * 0.01,
                        ),
                        FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Text(
                              "Book price (if the book for sale) ",
                              style: TextStyle(fontSize: 15),
                            )),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: myTextfeaildForm(
                            controller: _pricecontroller,
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
                            OnSaved: (value) {
                              if (selectedOption == "For Sale" &&
                                  value != null &&
                                  value.isNotEmpty) {
                                // Save the price here if needed
                              }
                            },
                            heighFactor: 0.08,
                            WidthFactor: 0.5,
                            paddingHorizontalFactor: 0.02,
                            paddingVerticalFactor: 0.01,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            KeyboardType: TextInputType.number,
                          ),
                        ),
    
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Text("Your location (approx)")),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.29,
                          width: screenWidth * 0.95,
                          //child: CurrentUserLocation(),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                         myelvatedbottom(
                          onPressed: _submitForm,
                          text: "Sumbit",
                         ),
                        SizedBox(
                          height: screenHeight * 0.07,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
