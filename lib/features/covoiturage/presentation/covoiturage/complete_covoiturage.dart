import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/core/widgets/textarea.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../../core/widgets/text_edit_covoiturage.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import '../../../authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import '../../domain/model/covoiturage_model.dart';
import '../actaulitie/bloc/covoiturage_bloc.dart';

class CompleteCovoiturage extends StatefulWidget {
  @override
  _CompleteCovoiturageState createState() => _CompleteCovoiturageState();
}

class _CompleteCovoiturageState extends State<CompleteCovoiturage> {
  TextEditingController departController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController tempDepartController = TextEditingController();
  TextEditingController nombrePersonnesController = TextEditingController();
  TextEditingController cotisationController = TextEditingController();

  bool? isChecked = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final titreReceived = args['titre'] as String;
    final photoReceived = args['photo'] as String;
    final descriptionReceived = args['description'] as String;
    final contactReceived = args['contact'] as String;
    bool _isDialogShown = false;
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
             //  SizedBox(height: 70,),//
          
              Padding(
                padding: const EdgeInsets.only(left: 0.0,right: 0.0),
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
          
                    SizedBox(height: 35,),//
          
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          TextEditCovoiturage(
                            validator: (value) {
                              if (value == null || value.isEmpty || value.length<3) {
                                return '3 caractéres au minimum';
                              }
                              return null;
                            },
                            controller: departController,
                            borderStyle: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            placeholder: 'Départ',
                            colorInputField: Color(0xFFD9D9D9), widthTextarea: 150, heightTextarea: 55,
                          ),
                          const SizedBox(width: 50,),
                          TextEditCovoiturage(
                            validator: (value) {
                              if (value == null || value.isEmpty || value.length<3) {
                                return '3 caractéres au minimum';
                              }
                              return null;
                            },
                            controller: destinationController,
                            borderStyle: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            placeholder: 'Destination ',
                            colorInputField: Color(0xFFD9D9D9), widthTextarea: 150, heightTextarea: 55,
                          ),
          
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFieldWidget(
                      validator: (value) {
                        debugPrint('I bring the value $value');
                        if (value == null || value.isEmpty) {
                          return 'Entrer un mot de passe valide ';
                        }
                        return null;
                      },
                      borderInput: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      controller: tempDepartController,
                      isTextObscure: false,
                      placeholder: 'Temps de départ',
                      iconPrefix: const Icon(Icons.timer_outlined, color: Colors.black38),
                      colorInputField: const Color(0xFFD9D9D9),
                    ),
                    TextFieldWidget(
                      validator: (value) {
                        debugPrint('I bring the value $value');
                        if (value == null || value.isEmpty || value.length !=1) {
                          return 'Nombre de personnes doit être un seul chiffre';
                        }
                        return null;
                      },
                      keyboardtype: TextInputType.number,
                      borderInput: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      controller: nombrePersonnesController,
                      isTextObscure: false,
                      placeholder: 'Nombre de personnes',
                      iconPrefix: const Icon(Icons.person_outline, color: Colors.black38),
                      colorInputField: const Color(0xFFD9D9D9),
                    ),
                    TextFieldWidget(
                      validator: (value) {
                        debugPrint('I bring the value $value');
                        if (value == null || value.isEmpty) {
                          return 'Cotisation ne doit pas etre vide';
                        }
                        return null;
                      },
                      borderInput: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      controller: cotisationController,
                      isTextObscure: false,
                      keyboardtype: TextInputType.number,
                      placeholder: 'Cotisation en dt',
                      iconPrefix: const Icon(Icons.attach_money, color: Colors.black38),
                      colorInputField: const Color(0xFFD9D9D9),
                    ),
                    const SizedBox(height: 25,),//
                    SaveWidgetButon(
                        buttonContent: 'Envoyer',
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
                                  const Color(0xFF1F7774),''

                                 //'/login'
                            );
                      } else
              {
                      if ((_formKey.currentState!).validate()) {
                          CovoiturageBloc covoiturageBloc = getIt<CovoiturageBloc>();

                          _formKey.currentState!.save();

                           if (!covoiturageBloc.isClosed) {
          

                                 CovoiturageModel covoiturage = CovoiturageModel(
                                     titre: titreReceived,
                                     type : 'covoiturage',
                                     description:descriptionReceived,
                                     photo: photoReceived,
                                     date : DateTime.now().toString(),
                                     contact: contactReceived,
                                      confirmed: 1,
                                   depart: departController.text,
                                   destination: destinationController.text,
                                   temps_depart: departController.text,
                                   cotisation: double.parse(cotisationController.text),
                                   nb_personnes: int.parse(nombrePersonnesController.text),
                                      )  ;
                                 debugPrint('event before sended $covoiturage') ;
                                 BlocProvider.of<CovoiturageBloc>(context).add(
                                    CovoiturageSaveEvent(
                                        covoiturage
                                    ),
                                  );
                                  debugPrint('Actualite is $covoiturage') ;
                                }
          
              }
              }
                      },),
                    BlocListener<CovoiturageBloc, CovoiturageState>(
                      listener: (context, state) {
                        if (state is CovoiturageSuccessMessageState && !_isDialogShown) {
                          /*  CovoiturageModel covoiturageElement = CovoiturageModel(
                                titre: titreController.text,
                                photo: photoController.text,
                                description: descriptionController.text,
                                date : DateTime.now().toString(),
                                contact: 'test',
                                type: 'general', confirmed: 0) ;
                            ListCovoiturages.covoituragesList.insert(0,covoiturageElement) ;*/
                          showValidationCredentials(
                              context,
                              'Ajoutée avec succées',
                              'Votre  atualité a été ajouée avec succées.',
                              Icons.check,
                              const Color(0xFF1F7774),
                              const Color(0xFF414141),
                              const Color(0xFF414141),
                              const Color(0xFF1F7774),'/listCovoiturages'
                            //'/login'
                          );
                          _isDialogShown = true;

                        }

                        else if(state is CovoiturageErrorState){
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

                    const SizedBox(height: 70,)//
          
                  ],

                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}