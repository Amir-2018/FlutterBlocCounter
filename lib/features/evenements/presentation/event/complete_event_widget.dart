import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/features/evenements/domain/model/event.dart';
import 'package:pfechotranasmartvillage/features/evenements/presentation/event/event_widget.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../../core/upload_image_from_camera_or_gallery.dart';
import '../../../../core/widgets/text_field_widget_annonces.dart';
import '../../../annonces/presentation/actaulitie/actualitie_widget.dart';
import '../../../authentication/domain/model/user.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'bloc/evenement_bloc.dart';

class CompleteEventWidget extends StatefulWidget {


  @override
  _CompleteEventWidgetState createState() => _CompleteEventWidgetState();
}

class _CompleteEventWidgetState extends State<CompleteEventWidget> {
  File? _image;
  String image64 = '';
  TextEditingController localisationController = TextEditingController();
  TextEditingController etablissementController = TextEditingController();
  TextEditingController limiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController lienController = TextEditingController();
  TextEditingController positionController = TextEditingController();



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? isChecked = true;

  Future<String> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
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
    String nom,category,dateDebut,dateFin ;

    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
     nom = args['nom'];
     category = args['category'];
     dateDebut = args['dateDebut'].toString();
     dateFin = args['dateFin'].toString();
    print('My nom est $nom') ;
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
                      SizedBox(
                        width: double.infinity,
                        height: 250,

                        child: SvgPicture.asset(
                          'assets/event/evenetImage.svg',
                          // Ensure the SVG covers the entire container
                        ),
                      ),
                      // const SizedBox(height: 25,),//

                     /* SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/megaphone.png')),*/
                      // Replace 'assets/background_image.jpg' with your actual image path
                      const SizedBox(height: 20,),
                      //

                      const Text('Continuer le formulaire',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: Color(0xff414141),

                        ),),
                      SizedBox(height: 35,),
                      //
                      GestureDetector(
                        onTap: (){
                          uploadImageFromCameraORGallery(context,ActualitieWidget.image64,_getImage) ;
                        },
                        child: Container(
                          width: 348,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : const Icon(Icons.add_a_photo, size: 35.0, color: Color(0xff7FB77E)),
                        ),
                      ),
                      SizedBox(height: 35,),

                      BlocListener<EvenementBloc, EvenementState>(
                              listener: (context, state) {
                                if(state is SendPositionState){
                                  setState(() {
                                    positionController.text = EventWidget.nomPosition;
                                  });
                                }
                              },
                              child: TextFieldWidgetAnnonces(
                          iconPrefix : Icon(Icons.location_on_outlined),
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty || value.length <
                              3) {
                            return 'Un titre doit avoir au-moins 3 caractéres ';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),//
                        ),
                        controller: positionController,
                        isTextObscure: false,
                        placeholder: 'Localisation',

                        colorInputField: const Color(0xFFD9D9D9), width: 348, height: 78,
                      ),
),

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
                        controller: localisationController,
                        isTextObscure: false,
                        placeholder: 'Etablissement',

                        colorInputField: const Color(0xFFD9D9D9), width: 348, height: 78,
                      ),

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
                        controller: limiteController,
                        isTextObscure: false,
                        placeholder: 'Limite',

                        colorInputField: const Color(0xFFD9D9D9), width: 348, height: 78,
                      ),

                      TextFieldWidgetAnnonces(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty || value.length <
                              3) {
                            return 'Un titre doit avoir au-moins 3 caractéres ';
                          }
                          return null;
                        },
                        maxlines: 5,
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: descriptionController,
                        isTextObscure: false,
                        placeholder: 'Description',

                        colorInputField: const Color(0xFFD9D9D9), width: 348, height: 78,
                      ),


                      const SizedBox(height: 15,),

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
                        controller: lienController,
                        isTextObscure: false,
                        placeholder: 'Lien',

                        colorInputField: const Color(0xFFD9D9D9), width: 348, height: 78,
                      ),
                      const SizedBox(height: 15,),

                      SaveWidgetButon(
                          buttonContent: 'Publier',
                          onTap: () async {
                            bool isConnected =
                            await checkConnection(); // Vérifier la connexion

                            if (!isConnected) {
                              showValidationCredentials(
                                  context,
                                  'Échec de la connexion',
                                  'Veuillez vérifier votre connexion Internet et réessayer.',
                                  Icons.error_outline,
                                  const Color(0xFFFF0000),
                                  const Color(0xFF414141),
                                  const Color(0xFF414141),
                                  const Color(0xFF1F7774),
                                  ''

                                //'/login'
                              );
                            } else {

                              String username = await getIt<Functions>().getUsername();
                                Evenement event =  Evenement(
                                    type: 'public',
                                    titre:nom,
                                    description: descriptionController.text,
                                    position: getIt<Functions>().stringToPointLocation(positionController.text.trim()),                                    limite: limiteController.text,
                                    photo: ActualitieWidget.image64,
                                    date_debut: dateDebut.toString(),
                                    date_fin: dateFin.toString(),
                                    category: category,
                                    localisation: localisationController.text,
                                    lienInscription: lienController.text,
                                    organisateur:username
                                ) ;

                              BlocProvider.of<EvenementBloc>(context).add(
                                  EvenementSaveEvent(
                             event
                                  ));
                            }
                          }
                      ),

                      const SizedBox(height: 10,),
                      BlocListener<EvenementBloc, EvenementState>(
                        listener: (context, state) {
                          if (state is EnevtSuccessState) {

                            showValidationCredentials(
                                context,
                                'Ajoutée avec succées',
                                'Votre  atualité a été ajouée avec succées.',
                                Icons.check,
                                const Color(0xFF1F7774),
                                const Color(0xFF414141),
                                const Color(0xFF414141),
                                const Color(0xFF1F7774),'/listAnnoces'
                              //'/login'
                            );
                          }
                          else if(state is EvenementErrorState){
                            showValidationCredentials(
                                context,
                                "Echeck d'ajout" ,
                                "Votre  actualité n'a été ajouée avec succées.",
                                Icons.error_outline,
                                const Color(0xFFFF0000),
                                const Color(0xFF414141),
                                const Color(0xFF414141),
                                const Color(0xFF1F7774),''
                              //'/login'
                            );
                          }else{
                            Container();
                          }
                        },
                        child: Container(),
                      ),

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
