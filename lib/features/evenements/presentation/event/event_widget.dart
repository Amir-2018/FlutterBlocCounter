import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/evenements/presentation/event/bloc/evenement_bloc.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../../core/widgets/dropdownmenu.dart';
import '../../../../core/widgets/text_field_widget_annonces.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
class EventWidget extends StatefulWidget {



  static String nomPosition = ''  ;
  static String nomEtablissement = ''  ;

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {

  DateTime? selectedDatedebut;
  DateTime? selectedDateFin;

  String dropdownValue = 'Conférence';
  File? _image;
  String image64 = '';
  TextEditingController nomController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController date_debutController = TextEditingController();
  TextEditingController date_finController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isChecked = true;

  Future<String> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      final functions = GetIt.I.get<Functions>();
      String base64String = await functions.loadAssetAsBase64(pickedFile.path);
      return base64String;
    } else {
      return Future.error('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          textAlign: TextAlign.center,
          // Center the text horizontally
          'Publier',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xff7FB77E),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
      ),
      body: Form(
        key: _formKey,

        child: Column(
          children: [
            const SizedBox(height: 35,), //

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      // const SizedBox(height: 25,),//

                      SizedBox(
                          width: double.infinity,
                          height: 250,

                          child: SvgPicture.asset(
                            'assets/event/evenetImage.svg',
                            // Ensure the SVG covers the entire container
                          ),
                      ),
                      // Replace 'assets/background_image.jpg' with your actual image path
                      const SizedBox(height: 20,),
                      //

                      const Text('Créer un nouvel évènement',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: Color(0xff414141),

                        ),),


                      SizedBox(height: 35,),
                      //


                      TextFieldWidgetAnnonces(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty || value.length <
                              3) {
                            return 'Un titre doit avoir au-moins 3 caractéres ';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: nomController,
                        isTextObscure: false,
                        placeholder: 'Nom',

                        colorInputField: const Color(0xFFD9D9D9), width: 348, height: 78,
                      ),



                      DropdownMenuExample(width: 348, height: 45,colorController: categoryController,),

                      SizedBox(height: 35,),
                      DateTimeFormField(
                        validator: (DateTime? value) {
                          if (value == null) {
                            return 'Please select a date';
                          }
                          return null;
                        },                        decoration: const InputDecoration(

                          labelText: 'Enter Date',
                        ),
                        firstDate: DateTime.now().add(const Duration(days: 10)),
                        lastDate: DateTime.now().add(const Duration(days: 40)),
                        initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                        onChanged: (DateTime? value) {
                          selectedDatedebut = value;
                        },
                      ),
                      SizedBox(height: 20,),

                      DateTimeFormField(
                        validator: (DateTime? value) {
                          if (value == null) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter Date',
                        ),
                        firstDate: DateTime.now().add(const Duration(days: 10)),
                        lastDate: DateTime.now().add(const Duration(days: 40)),
                        initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                        onChanged: (DateTime? value) {
                          selectedDateFin = value;
                        },
                      ),


                      const SizedBox(height: 15,),

                      SaveWidgetButon(
                        height: 48,
                        borderRadius: 5.0,
                          buttonContent: 'Continuer',
                          onTap: ()  {
                            if ((_formKey.currentState!).validate()) {
                                Navigator.pushNamed(
                                  context,
                                  '/completeEvent',
                                  arguments: {
                                    'nom': nomController.text,
                                    'category': categoryController.text,
                                    'dateDebut': selectedDatedebut,
                                    'dateFin': selectedDateFin,
                                  },
                                );
                            }
                          }
                        // },

                      ),
                      const SizedBox(height: 15,),



                      const SizedBox(height: 10,),
                      //

                    ],
                  ),
                ),
              ),
            ),

            const ButtonNavigationBar(),
          ],
        ),
      ),
    );
  }
}
