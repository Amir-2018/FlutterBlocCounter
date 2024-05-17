import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfechotranasmartvillage/features/evenements/presentation/event/bloc/evenement_bloc.dart';
import 'package:pfechotranasmartvillage/features/evenements/presentation/event/event_widget.dart';

import '../../features/map_interactive/presentation/widgets/map_elements/bloc_etablissement/etablissement_bloc.dart';
import 'map_for_pop_up.dart';

class TextFieldWidgetAnnonces extends StatelessWidget {
  final String? Function(String?)? validator;
  final controller;
  final borderStyle;
  final bool isTextObscure;
  final String? placeholder;
  final Icon? iconPrefix;
  final Color colorInputField;
  final TextInputType? keyboardtype;
  final OutlineInputBorder? borderInput;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final int? maxlines;


  const TextFieldWidgetAnnonces({
    super.key,
    this.maxlines,
    this.textStyle,
    this.borderStyle,
    this.borderInput,
    this.keyboardtype,
    this.validator,
    this.placeholder,
    this.iconPrefix,
    required this.controller,
    required this.isTextObscure,
    required this.colorInputField,
    required this.width,
    required this.height,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF414141),
          fontWeight: FontWeight.bold,
        ),
        keyboardType: keyboardtype,
        controller: controller,
        obscureText: isTextObscure,
        validator: validator,
        maxLines: maxlines,
        decoration: InputDecoration(


          suffixIcon: iconPrefix != null
              ? GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Localisation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: SizedBox(
                      height: 400,
                      width: 500,
                      child: MapPopUP(
                        onPicked: (PickedData pickedData) {},
                      ),
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Add border radius
                    ),
                    contentPadding: const EdgeInsets.all(16), // Add content padding
                    backgroundColor: Colors.white, // Set background color
                    elevation: 8,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {

                          BlocProvider.of<EvenementBloc>(context).add(
                              SendPositionEvent()
                          );

                          Navigator.of(context).pop(); // Ferme l'AlertDialog
                        },
                        child: const Text('Ajouter'),
                      ),
                    ],// Add elevation
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                iconPrefix!.icon,
                color: Colors.black38,
              ),
            ),
          )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 1,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF414141),
            fontWeight: FontWeight.normal,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}