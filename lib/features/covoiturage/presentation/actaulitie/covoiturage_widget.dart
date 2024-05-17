import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/core/widgets/textarea.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import '../../../authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import '../../data/implementation/covoiturage_repo_impl.dart';
import '../../domain/usecases/get_list_covoiturages_by_title_usecase.dart';
import '../../domain/usecases/get_list_covoiturages_usecase.dart';
import '../../domain/usecases/insert_covoiturage_usecase.dart';
import 'bloc/covoiturage_bloc.dart';
import '../../../../features/annonces/domain/model/actualite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CovoiturageWidget extends StatefulWidget {
  @override
  _CovoiturageState createState() => _CovoiturageState();
}

class _CovoiturageState extends State<CovoiturageWidget> {
  File? _image;
  final _picker = ImagePicker();
  TextEditingController titreController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? isChecked = true;
  bool _isDialogShown = false;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if (!getIt.isRegistered<CovoiturageBloc>()) {
      getIt.registerLazySingleton<CovoiturageBloc>(
            () =>
                CovoiturageBloc(InsertCovoiturageUsecase(
                    covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecase(covoiturageRepository: CovoiturageRepositoryImpl()),GetListCovoituragesUsecaseByTitle(covoiturageRepository: CovoiturageRepositoryImpl())),
      );
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(textAlign: TextAlign.center, // Center the text horizontally
          'Publier',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Color(0xff7FB77E),
    iconTheme: const IconThemeData(color: Colors.white,size: 24),
   ),
      body: Form(
        key: _formKey,

        child: Column(
          children: [
            const SizedBox(height: 35,),//

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                  
                    children: [
                     // const SizedBox(height: 25,),//
                  
                      SizedBox(
                          width : 100,
                          height : 100,
                          child: Image.asset('assets/carService.png')), // Replace 'assets/background_image.jpg' with your actual image path
                      const SizedBox(height: 20,),//
                  
                      const Text('Publier Actualité',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xff414141),
                  
                        ),),
                      SizedBox(height: 35,),//
                  
                  
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty || value.length<3) {
                            return 'Un titre doit avoir au-moins 3 caractéres ';
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
                  
                  
                      Textarea(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length<8) {
                            return "Priére d'écrire  au minimum de 8 caractéres";
                          }
                          return null;
                        },
                        controller: descriptionController,
                        borderStyle: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        placeholder: 'Ecrire votre description ici ... ',
                        colorInputField: Color(0xFFD9D9D9), widthTextarea: 348,
                      ),
                      const SizedBox(height: 22,) ,
                  
                      GestureDetector(
                        onTap: _getImage,
                        child: Container(
                          width: 348,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : Icon(Icons.add_a_photo, size: 60.0,color : Color(0xff7FB77E)),
                        ),
                      ),
                      const SizedBox(height: 15,) ,
                  
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
                              const Color(0xFF1F7774),''
                  
                              //'/login'
                            );
                          } else
                          {
                            if ((_formKey.currentState!).validate()) {
                              CovoiturageBloc covoiturageBloc = getIt<CovoiturageBloc>();

                              _formKey.currentState!.save();
                              debugPrint('Image is $_image');

                             /* if (!covoiturageBloc.isClosed) {

                               CovoiturageModel covoiturage = CovoiturageModel(
                                   titre: titreController.text,
                                   type : 'general',
                                   description: descriptionController.text,
                                   photo: _image.toString(),
                                   date : DateTime.now().toString(),
                                   contact: 'test', confirmed: 0)  ;
                                BlocProvider.of<CovoiturageBloc>(context).add(
                                  CovoiturageSaveEvent(
                                      covoiturage
                                  ),
                                );
                                debugPrint('Actualite is $covoiturage') ;
                              }*/

                            }
                          }
                        },

                      ),
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
                              const Color(0xFF1F7774),'/listAnnoces'
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
                      const SizedBox(height: 10,),//

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