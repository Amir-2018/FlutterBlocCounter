
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/textarea.dart';
import 'package:pfechotranasmartvillage/features/annonces/domain/usecases/get_actualities_of_today_usecase.dart';
import 'package:pfechotranasmartvillage/features/annonces/presentation/list_annonce/list_annonce.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/default_image/default_images.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import '../../../authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import '../../../../core/upload_image_from_camera_or_gallery.dart';
import '../../data/implementation/actualite_repo_impl.dart';
import '../../domain/usecases/get_list_actualities_by_title_usecase.dart';
import '../../domain/usecases/get_list_actualities_usecase.dart';
import '../../domain/usecases/insert_actualitie_usecase.dart';
import 'bloc/actualite_bloc.dart';
import '../../../../features/annonces/domain/model/actualite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ActualitieWidget extends StatefulWidget {
  static String image64 = '' ;

  @override
  _ActualitieState createState() => _ActualitieState();
}

class _ActualitieState extends State<ActualitieWidget> {
  File? _image;
  final _picker = ImagePicker();
  TextEditingController titreController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? isChecked = true;
  bool _isDialogShown = false;

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

    if (!getIt.isRegistered<ActualiteBloc>()) {
      getIt.registerLazySingleton<ActualiteBloc>(
            () =>
            ActualiteBloc(InsertActualityUsecase(
                actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecase(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesUsecaseByTitle(actualiteRepository: ActualiteRepositoryImpl()),GetListActualitiesOfTodayeUsecase(actualiteRepository: ActualiteRepositoryImpl())),
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
                          child: Image.asset('assets/megaphone.png')), // Replace 'assets/background_image.jpg' with your actual image path
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
                        onTap: () {
                          uploadImageFromCameraORGallery(context,ActualitieWidget.image64,_getImage) ;
                        },
                        child: Container(
                          width: 348,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : const Icon(Icons.add_a_photo, size: 60.0, color: Color(0xff7FB77E)),
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
                              ActualiteBloc actualiteBloc = getIt<ActualiteBloc>();

                              _formKey.currentState!.save();
                              //debugPrint('Image is $image64');

                              if (!actualiteBloc.isClosed) {
                                if(ActualitieWidget.image64==''){

                                  ActualitieWidget.image64 = ANNONCEImage ;
                                }
                               Actualite actualite = Actualite(
                                   titre: titreController.text,
                                   type : 'general',
                                   description: descriptionController.text,
                                   photo: ActualitieWidget.image64,
                                   date : DateTime.now().toString(),
                                   contact: 'test', confirmed: 1)  ;
                                BlocProvider.of<ActualiteBloc>(context).add(
                                  ActualiteSaveEvent(
                                    actualite
                                  ),
                                );
                                debugPrint('Actualite is $actualite') ;
                              }

                            }
                          }
                        },

                      ),
                      BlocListener<ActualiteBloc, ActualiteState>(
                        listener: (context, state) {
                          if (state is ActualiteSuccessMessageState && !_isDialogShown) {
                            Actualite actualiteElement = Actualite(
                                titre: titreController.text,
                                photo: photoController.text,
                                description: descriptionController.text,
                                date : DateTime.now().toString(),
                                contact: 'test',
                                type: 'general', confirmed: 0) ;
                            ListAnnoces.actulitesList.insert(0,actualiteElement) ;
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

                          else if(state is ActualiteErrorState){
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