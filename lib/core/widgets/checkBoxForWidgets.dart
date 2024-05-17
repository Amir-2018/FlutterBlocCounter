import 'package:flutter/material.dart';

class CheckboxForWidgets extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  CheckboxForWidgets({super.key, required this.initialValue, required this.onChanged});

  @override
  State<CheckboxForWidgets> createState() => _CheckboxForWidgetsState();
}

class _CheckboxForWidgetsState extends State<CheckboxForWidgets> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return const Color(0xff82B881);
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onChanged(isChecked);
          },
        ),
        const Text('Suivre réclamation par email')
      ],
    );
  }
}
