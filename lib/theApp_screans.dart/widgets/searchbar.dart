// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';



class CustomSearchBar extends StatelessWidget {
   final SearchController searchController;
  final List<String> allItems;
  const CustomSearchBar({super.key,  required this.searchController, required this.allItems});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return SearchAnchor(
      searchController: searchController,
      builder: (context, controller) {
        return SizedBox(
          height:screenHeight*0.05,
          width: MediaQuery.of(context).size.width*0.9,
          child: SearchBar(
            controller: searchController,
            hintText: "search...",
            onChanged: (query) {
              controller.openView();
            },
            onTap: () {
              controller.openView();
            },
            leading: IconButton(
              onPressed: () {
                controller.openView();
              },
              icon: Icon(Icons.search),
            ),
          ),
        );
      },
      suggestionsBuilder: (context, controller) {
        String query = controller.text.toLowerCase();
        List<String> filteredItems = allItems
            .where((item) => item.toLowerCase().contains(query))
            .toList();

        return filteredItems.map((result) {
          return ListTile(
            title: Text(result),
            onTap: () {
              searchController.closeView(result);
            },
          );
        }).toList();
      },
    );
  }
}
