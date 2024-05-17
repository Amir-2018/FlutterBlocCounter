import 'package:flutter/material.dart';

enum Types { conference, Jeux, Ouverture }

class DropdownMenuExample extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController colorController;
  final TextEditingController? iconController;

  const DropdownMenuExample({
    Key? key,
    required this.width,
    required this.height,
    required this.colorController,
    this.iconController,
  }) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  Types? selectedItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: widget.width,
      height: widget.height,
      child: DropdownMenu<Types>(
        width: widget.width,
        initialSelection: selectedItems ?? Types.conference,
        controller: widget.colorController,
        requestFocusOnTap: true,
        onSelected: (Types? color) {
          setState(() {
            selectedItems = color;
          });
        },
        dropdownMenuEntries: Types.values
            .map<DropdownMenuEntry<Types>>(
                (Types type) {
              return DropdownMenuEntry<Types>(
                value: type,
                label: type.name,
                enabled: type.name != 'Grey',
                style: MenuItemButton.styleFrom(
                  // foregroundColor: type.color,
                ),
              );
            }).toList(),
      ),
    );
  }
}