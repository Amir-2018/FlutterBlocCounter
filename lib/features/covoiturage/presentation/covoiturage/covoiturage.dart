import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfechotranasmartvillage/core/widgets/textarea.dart';
import '../../../../core/widgets/text_edit_covoiturage.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import '../../../authentication/presentation/widgets/subwidgets/textFieldWidget.dart';

class Covoiturage extends StatefulWidget {
  @override
  _CovoiturageState createState() => _CovoiturageState();
}

class _CovoiturageState extends State<Covoiturage> {
  TextEditingController titreController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController textAreaController = TextEditingController();

  bool? isChecked = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // This removes the shadow
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 70,),//
          
              Padding(
                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  
                    children: [
                  
                      SizedBox(
                          width : 100,
                          height : 100,
                          child: Image.asset('assets/annonces/car.png')), // Replace 'assets/background_image.jpg' with your actual image path
                  
                      const Text('Publier Covoiturage',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xff414141),
                  
                        ),),
                  
                      const SizedBox(height: 35,),//
                  
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty || value.length<3) {
                            return 'Un titre doit avoir 3 caractéres au minimum';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: titreController,
                        isTextObscure: false,
                        placeholder: 'Titre',
                        iconPrefix: const Icon(Icons.edit_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),
                  
                      /*TextFieldWidget(

                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: photoController,
                        isTextObscure: true,
                        placeholder: 'Photo',
                        iconPrefix: const Icon(Icons.camera_alt_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),*/
                  
                      Textarea(
                        validator: (value) {
                          if (value == null || value.isEmpty|| value.length<10) {
                            return 'Description doit avoir 10 caractéres au minimum';
                          }
                          return null;
                        },
                        controller: descriptionController,
                        borderStyle: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        placeholder: 'Description ... ',
                        colorInputField: Color(0xFFD9D9D9), widthTextarea: 348,
                      ),
                      const SizedBox(height: 20,),
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty) {
                            return 'Un contact doit avoir 8 chiffres';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: contactController,
                        keyboardtype: TextInputType.number,
                        isTextObscure: true,
                        placeholder: 'Contact',
                        iconPrefix: const Icon(Icons.phone_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),
                      SaveWidgetButon(
                          buttonContent: 'Continuer',
                          onTap: () {
                            if ((_formKey.currentState!).validate()) {
                              photoController.text = '' ;
                            _formKey.currentState!.save();
                            Navigator.pushNamed(context, '/completeCovoiturage',
                              arguments: {
                              'titre': titreController.text,
                              'photo': photoController.text,
                                'description': descriptionController.text,
                                'contact' : contactController.text
                            },) ;}
          
                          }
                      ),
                  
                    ],
                  ),
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}