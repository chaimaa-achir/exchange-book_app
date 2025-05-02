// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project/helpers/getlocation.dart';
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
  LatLng? savedLocation;

  @override
  void initState() {
    super.initState();
    loadSavedLocation();
  }

  Future<void> loadSavedLocation() async {
    final location = await LocationStorage.getSavedLocation();
    setState(() {
      savedLocation = location;
    });
  }

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

  void _submitForm() async {
    // التحقق من الصورة أولاً
    if (bookImage == null) {
      setState(() {
        imageError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a book image',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (_titlecontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Title is required',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (_authorcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Author is required',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    }

    // التحقق من صحة النموذج
    if (!_formkey.currentState!.validate()) {
      return;
    }

    // حفظ البيانات من النموذج
    _formkey.currentState!.save();
    String title = _titlecontroller.text;
    String author = _authorcontroller.text;
    String description = _descriptioncontroller.text;
    String price = _pricecontroller.text;

    // التحقق من السعر إذا كان نوع المعاملة بيع
    if (selectedOption == "For Sale" &&
        (price.isEmpty ||
            double.tryParse(price) == null ||
            double.parse(price) <= 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid price for the book',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // التحقق من تحديد نوع المعاملة
    if (selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a transaction type',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // عرض مؤشر التحميل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // // طباعة معلومات التصحيح
      // print('======== SUBMIT FORM ========');
      // print('Uploading book with details:');
      // print('Title: $title');
      // print('Author: $author');
      // print('Description: ${description.isNotEmpty ? description : "(empty)"}');
      // print('Transaction Type: $selectedOption');
      // print('Price: ${price.isNotEmpty ? price : "(empty)"}');
      // print('Image: ${bookImage?.path ?? "none"}');

      // محاولة رفع الكتاب
      await uploadBook(
        title: title,
        author: author,
        description: description,
        transactionType: selectedOption!,
        bookImage: bookImage,
        price: price,
      );

      // إغلاق مؤشر التحميل
      Navigator.of(context).pop();

      // عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The book has been uploaded successfully!',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ),
      );

      // إعادة تعيين النموذج والعودة للشاشة السابقة
      setState(() {
        bookImage = null;
        _titlecontroller.clear();
        _authorcontroller.clear();
        _descriptioncontroller.clear();
        _pricecontroller.clear();
        selectedOption = null;
      });

      Navigator.pop(context); // العودة للشاشة السابقة
    } catch (error) {
      // إغلاق مؤشر التحميل في حالة حدوث خطأ
      Navigator.of(context).pop();

      // طباعة تفاصيل الخطأ للتصحيح
      print('======== ERROR DETAILS ========');
      print('Error uploading book: $error');
      print('================================');

      // عرض رسالة الخطأ للمستخدم مع تفاصيل أكثر
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to upload the book: ${error.toString().substring(0, error.toString().length > 50 ? 50 : error.toString().length)}...',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'DETAILS',
            textColor: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Error Details'),
                  content: SingleChildScrollView(
                    child: Text(error.toString()),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text('OK'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }

// دالة الاتصال بالـ API لرفع الكتاب
  Future<void> uploadBook({
    required String title,
    required String author,
    required String description,
    required String transactionType,
    required File? bookImage,
    required String price,
  }) async {
    try {
      // 1. جلب البيانات من SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      double? latitude = prefs.getDouble('latitude');
      double? longitude = prefs.getDouble('longitude');

      if (token == null || latitude == null || longitude == null) {
        throw Exception('Missing data (token or location)');
      }

      // 2. تحويل نوع المعاملة إلى التنسيق المتوقع من API
      String apiTransactionType;
      switch (transactionType) {
        case "For Sale":
          apiTransactionType = "Sale";
          break;
        case "Exchange":
          apiTransactionType = "Exchange";
          break;
        case "Lending":
          apiTransactionType = "Lending";
          break;
        default:
          throw Exception('Invalid transaction type');
      }

      print('Transaction type: $transactionType -> $apiTransactionType');

      // 3. تجهيز الطلب
      var uri = Uri.parse('https://books-paradise.onrender.com/post/add-book');
      var request = http.MultipartRequest('POST', uri);

      // إضافة التوكن (جرب طريقتين مختلفتين)
      request.headers['Authorization'] = 'Bearer $token';

      // 4. إضافة البيانات المطلوبة
      request.fields['title'] = title;
      request.fields['author'] = author;
      request.fields['transaction_type'] = apiTransactionType;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();

      // إضافة السعر فقط إذا كان نوع المعاملة بيع
      if (apiTransactionType == "Sale") {
        request.fields['price'] = price.isEmpty ? '0' : price;
      }

      // إضافة الوصف (caption) إذا كان موجوداً
      if (description.isNotEmpty) {
        request.fields['caption'] = description;
      }

      // 5. إضافة الصورة إذا موجودة
      if (bookImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('cover_image', bookImage.path));
      }

      // طباعة محتويات الطلب للتصحيح
      print('Request fields: ${request.fields}');
      print('Request headers: ${request.headers}');
      print('Request files: ${request.files.length}');

      // 6. إرسال الطلب
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      print('Response status code: ${response.statusCode}');
      print('Response data: $responseData');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('The book has been uploaded successfully.');
      } else {
        print('Failed to upload book: $responseData');
        throw Exception('Failed to upload book: Status ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
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
                                height: screenHeight * 0.045,
                              ),
                              myTextfeaildForm(
                                controller: _titlecontroller,
                                // validator: (value) {
                                //   if (value == null || value.trim().isEmpty) {
                                //     return "Title is required!";
                                //   }
                                //   return null;
                                // },
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
                                height: screenHeight * 0.045,
                              ),
                              myTextfeaildForm(
                                controller: _authorcontroller,
                                // validator: (value) {
                                //   if (value == null || value.trim().isEmpty) {
                                //     return "Author is required!";
                                //   }
                                //   return null;
                                // },
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
                                height: screenHeight * 0.045,
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
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 160, 107, 186)),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
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
                              selectedOption = value;
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
                        SizedBox(
                          height: screenHeight * 0.01,
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
                          child: savedLocation != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: savedLocation!,
                                      zoom: 15,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: MarkerId("saved_location"),
                                        position: savedLocation!,
                                      ),
                                    },
                                    zoomControlsEnabled: false,
                                    myLocationEnabled: false,
                                    onMapCreated: (controller) {},
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'No location saved.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        myelvatedbottom(
                          onPressed: _submitForm,
                          child: Text("Sumbit",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
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
