import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';



class requestPAge extends StatefulWidget {
  final Book book;
  const requestPAge({super.key, required this.book});
  @override
  State<requestPAge> createState() => _requestPAgeState();
}

class _requestPAgeState extends State<requestPAge> {
  String? selectedDurationType;
  int? selectedDuration;
  // Show Submenu for Number Selection
  void _showSubMenu(BuildContext context, String type) async {
    int? selectedNumber = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(100, 300, 100, 0),
      items: List.generate(
        type == "Days" ? 30 : 12,
        (index) => PopupMenuItem<int>(
          value: index + 1,
          child: Text("${index + 1}"),
        ),
      ),
    );

    if (selectedNumber != null) {
      setState(() {
        selectedDuration = selectedNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      final screenHeight =MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 18,
          title: Text("Make a request"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.5,
              width:screenWidth* 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Image.asset("assets/img/history.jpg"),
            ),
            // Main DropdownButtonFormField
            FractionallySizedBox(
              widthFactor: 0.9,
              child: DropdownButtonFormField<String>(
                value: selectedDurationType,
                decoration: InputDecoration(
                  labelText: "Select Duration",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDurationType = newValue;
                    selectedDuration = null; // Reset number selection
                  });
                  if (newValue != null) {
                    _showSubMenu(context, newValue);
                  }
                },
                items: [
                  DropdownMenuItem(value: "Days", child: Text("Days")),
                  DropdownMenuItem(value: "Months", child: Text("Months")),
                ],
              ),
            ),

            // Display the selected number only after choosing from submenu
            if (selectedDuration != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Selected Duration: $selectedDuration $selectedDurationType",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
    // Show Submenu for Number Selection
  }
}
