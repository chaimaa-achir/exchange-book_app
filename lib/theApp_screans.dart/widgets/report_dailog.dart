import 'package:flutter/material.dart';

void showReportOptions(BuildContext context,Function(String reason) onSelected) {
  final List<String> reportResons = [
    'Sharing personal data',
    'Advertising / selling',
    'Offering / requesting item',
    'Inappropriate / offensive',
    'Asking for money',
    'Other',
  ];
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: reportResons.map((reason) {
            return ListTile(
              title: Text(reason),
              onTap: () {
                Navigator.pop(context);
                onSelected(reason);
              },
            );
          }).toList(),
        );
      });
}
