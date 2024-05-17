import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/textarea.dart';
import 'package:pfechotranasmartvillage/features/annonces/presentation/list_annonce/list_annonce.dart';
import 'package:pfechotranasmartvillage/features/reclamation/domain/usecases/insert_actualitie_usecase.dart';
import 'package:pfechotranasmartvillage/features/reclamation/presentation/reclamation/bloc/reclamation_bloc.dart';
import 'package:pfechotranasmartvillage/core/upload_image_from_camera_or_gallery.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/default_image/default_images.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../../core/widgets/checkBoxForWidgets.dart';
import '../../../annonces/presentation/actaulitie/actualitie_widget.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import '../../../authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/implementation/reclamation_repo_impl.dart';
import '../../domain/model/reclamation.dart';

class ReclamationWidget extends StatefulWidget {

  @override
  _ReclamationWidgetState createState() => _ReclamationWidgetState();
}

class _ReclamationWidgetState extends State<ReclamationWidget> {
  @override
  void initState() {
    ActualitieWidget.image64 = '' ;
    super.initState();
  }
  File? _image;
  final _picker = ImagePicker();
  TextEditingController sujetController = TextEditingController();
  TextEditingController contenuController = TextEditingController();
  TextEditingController emailtionController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController isCheckedController = TextEditingController();
  TextEditingController etatController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isDialogShown = false;
  bool isCheckedValue  = false ;

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

    if (!getIt.isRegistered<ReclamationBloc>()) {
      getIt.registerLazySingleton<ReclamationBloc>(
            () =>
            ReclamationBloc(InsertReclamationUsecase(
               reclamationRepository: ReclamtionRepositoryImpl()))
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(textAlign: TextAlign.center, // Center the text horizontally
          'Réclamation',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Color(0xff7FB77E),
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
                          child: Image.asset('assets/claim.png')), // Replace 'assets/background_image.jpg' with your actual image path
                      const SizedBox(height: 20,),//

                      const Text('Signaler une réclamation',
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
                            return 'Sujet doit avoir au-moins 3 caractéres ';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: sujetController,
                        isTextObscure: false,
                        placeholder: 'Sujet',
                        iconPrefix: const Icon(Icons.edit_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),


                      Textarea(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length<8) {
                            return "Priére d'écrire  au minimum de 10 caractéres";
                          }
                          return null;
                        },
                        controller: contenuController,
                        borderStyle: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        placeholder: 'Ecrire votre description ici ... ',
                        colorInputField: Color(0xFFD9D9D9), widthTextarea: 348,
                      ),
                      const SizedBox(height: 22,) ,


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
                      const SizedBox(height: 15,) ,
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty ) {
                            return 'Un email ne doit pas être vide';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: emailtionController,
                        isTextObscure: false,
                        placeholder: 'Email',
                        iconPrefix: const Icon(Icons.edit_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),
                      const SizedBox(height: 15,) ,

                      CheckboxForWidgets(
                        initialValue: false,
                        onChanged: (isChecked) {
                          isCheckedValue = isChecked ;
                          print('isChecked value = $isCheckedValue') ;
                        },
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
                              ReclamationBloc actualiteBloc = getIt<ReclamationBloc>();

                              _formKey.currentState!.save();

                              if (!actualiteBloc.isClosed) {
                                if(ActualitieWidget.image64==''){

                                  ActualitieWidget.image64 = ANNONCEImage ;
                                }
                                Reclamation reclamation = Reclamation(
                                    sujet: sujetController.text,
                                    contenu: contenuController.text,
                                    email: emailtionController.text,
                                    photo : ActualitieWidget.image64,
                                    etat: 'EN_ATTENTE',
                                    isChecked: isCheckedValue)  ;
                                print('I will send the value = $isCheckedValue') ;
                                BlocProvider.of<ReclamationBloc>(context).add(
                                  ReclamationSendEvent(
                                      reclamation
                                  ),
                                );
                              }

                            }
                          }
                        },

                      ),
                      BlocListener<ReclamationBloc, ReclamationState>(
                        listener: (context, state) {
                          if (state is ReclamationSuccessState && !_isDialogShown) {

                            showValidationCredentials(
                                context,
                                'Ajoutée avec succées',
                                'Votre  Réclamation a été envoyée avec succées.',
                                Icons.check,
                                const Color(0xFF1F7774),
                                const Color(0xFF414141),
                                const Color(0xFF414141),
                                const Color(0xFF1F7774),'/services'
                              //'/login'
                            );
                            _isDialogShown = true;

                          }

                          else if(state is ReclamationErrorState){
                            showValidationCredentials(
                                context,
                                "Echeck d'envoie" ,
                                "Votre  réclamation n'a pas été envoyée.",
                                Icons.error_outline,
                                const Color(0xFFFF0000),
                                const Color(0xFF414141),
                                const Color(0xFF414141),
                                const Color(0xFF1F7774),'/services'
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