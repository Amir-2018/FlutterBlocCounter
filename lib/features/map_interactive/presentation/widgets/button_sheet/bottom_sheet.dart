import 'package:flutter/material.dart';

Widget buildBottomSheet(BuildContext context, List<int> selectedCategories, Function(int, bool) onCategorySelected) {
  return Container(
    height: 250,
    child: Column(
      children: [
        const Padding(
          padding:  EdgeInsets.all(8.0),
          child:  Text(
            'Choose a category',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7FB77E),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              bool isSelected = selectedCategories.contains(index);
              return CheckboxListTile(
                value: isSelected,
                onChanged: (value) {
                  onCategorySelected(index, value!);
                },
                title: Row(
                  children: [
                    Icon(
                      getIconForIndex(index),
                      color: Color(0xFF7FB77E),
                    ),
                    SizedBox(width: 8),
                    Text(getTitleForIndex(index)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

IconData getIconForIndex(int index) {
  switch (index) {
    case 0:
      return Icons.factory;
    case 1:
      return Icons.business;
    case 2:
      return Icons.school;
    case 3:
      return Icons.mosque;
    default:
      return Icons.error;
  }
}

String getTitleForIndex(int index) {
  switch (index) {
    case 0:
      return 'Industries';
    case 1:
      return 'Entreprises';
    case 2:
      return 'Universités';
    case 3:
      return 'Mosquées';
    default:
      return 'Error';
  }
}