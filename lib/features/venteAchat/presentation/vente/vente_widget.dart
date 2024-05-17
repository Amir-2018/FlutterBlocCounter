import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pfechotranasmartvillage/core/widgets/textarea.dart';
import 'package:pfechotranasmartvillage/features/annonces/presentation/list_annonce/list_annonce.dart';
import '../../../../core/connection_management.dart';
import '../../../../core/default_image/default_images.dart';
import '../../../../core/dependencies_injection.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/pop_up_messages.dart';
import '../../../annonces/presentation/actaulitie/actualitie_widget.dart';
import '../../../authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import '../../../authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import '../../../authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import '../../../../core/upload_image_from_camera_or_gallery.dart';
import '../../data/implementation/vente_achat_repository_impl.dart';
import '../../domain/model/vente.dart';
import '../../domain/usecases/get_list_ventes_by_title_usecase.dart';
import '../../domain/usecases/get_list_ventes_usecase.dart';
import '../../domain/usecases/insert_vente_usecase.dart';
import 'bloc/vente_bloc.dart';
import '../../../../features/annonces/domain/model/actualite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VenteWidget extends StatefulWidget {
  static  String typeAnnonce = 'vente' ;

  @override
  _ActualitieState createState() => _ActualitieState();
}

class _ActualitieState extends State<VenteWidget> {

  File? _image;
  String image64 = '' ;
  final _picker = ImagePicker();


  // Controllers

  TextEditingController objetContoller = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
  void initState() {
    ActualitieWidget.image64 = '' ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if (!getIt.isRegistered<VenteBloc>()) {
      getIt.registerLazySingleton<VenteBloc>(
            () =>
                VenteBloc(InsertVenteUsecase(
                venteRepository: VenteAchatRepositoryImpl()),GetListVentesUsecase(venteRepository: VenteAchatRepositoryImpl()),GetListVentesByTitleUsecase(venteRepository: VenteAchatRepositoryImpl())),
      );
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(textAlign: TextAlign.center, // Center the text horizontally
          'Publier',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Color(0xff7FB77E),
          iconTheme: const IconThemeData(color: Colors.white, size: 24),

   ),
      body: Form(
        key: _formKey,

        child: Column(
          children: [
            const SizedBox(height: 45,),//

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
                          child: Image.asset('assets/venteAchat/sale.png')), // Replace 'assets/background_image.jpg' with your actual image path
                      const SizedBox(height: 20,),//
                  
                       Text('Publier ${VenteWidget.typeAnnonce}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xff414141),
                  
                        ),),
                      const SizedBox(height: 35,),//
                  
                  
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty ) {
                            return 'Titre ne doit pas être vide';
                          }else if (value.length<3){
                            return 'Un titre  doit avoir 3 caractéres au minimum';

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

                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty ) {
                            return 'Objet ne doit pas être vide';
                          }else if (value.length<3){
                            return 'Objet  doit avoir  au minimum 3 caractéres';

                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: objetContoller,
                        isTextObscure: false,
                        placeholder: 'Objet',
                        iconPrefix: const Icon(Icons.question_mark, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty) {
                            return 'Prix ne doit pas être vide';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: prixController,
                        isTextObscure: false,
                        keyboardtype: TextInputType.number,
                        placeholder: 'Prix en dt',
                        iconPrefix: const Icon(Icons.monetization_on_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),
                      TextFieldWidget(
                        validator: (value) {
                          debugPrint('I bring the value $value');
                          if (value == null || value.isEmpty) {
                            return 'Quantité ne doit pas être vide';
                          }
                          return null;
                        },
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        keyboardtype: TextInputType.number,
                        controller: quantityController,
                        isTextObscure: false,
                        placeholder: 'Quantité',
                        iconPrefix: const Icon(Icons.format_list_numbered, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
                      ),
                  
                      Textarea(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantité doit pas être  vide';
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
                      TextFieldWidget(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length !=8) {
                            return 'Contact doit avoir 8 chiffres';
                          }
                          return null;
                        },
                        keyboardtype: TextInputType.number,
                        borderInput: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: phoneController,
                        isTextObscure: false,
                        placeholder: 'Contact',
                        iconPrefix: const Icon(Icons.phone_outlined, color: Colors.black38),
                        colorInputField: const Color(0xFFD9D9D9),
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
                              VenteBloc venteBloc = getIt<VenteBloc>();

                              _formKey.currentState!.save();

                              if (!venteBloc.isClosed) {
                                if(ActualitieWidget.image64==''){

                                  ActualitieWidget.image64 = ANNONCEImage ;
                                }
                               Vente vente = Vente(
                                   titre: titreController.text,
                                  photo: ActualitieWidget.image64,
                                  description: descriptionController.text,
                                   date : DateTime.now().toString(),
                                   objet: objetContoller.text,
                                   prix: double.parse(prixController.text),
                                 contact: '',

                                 quantite: int.parse(quantityController.text),
                                 type: 'achatvente',
                                 confirmed: 0,
                                 annonceAchat: 0,
                               )  ;
                                BlocProvider.of<VenteBloc>(context).add(
                                  VenteSaveEvent(
                                    vente
                                  ),
                                );
                              }

                            }
                          }
                        },

                      ),
                      BlocListener<VenteBloc, VenteState>(
                        listener: (context, state) {
                          if (state is VenteSuccessMessageState && !_isDialogShown) {
                            Actualite actualiteElement = Actualite(titre: titreController.text, photo: photoController.text, description: descriptionController.text,date : DateTime.now().toString(),contact: '', type: 'general', confirmed: 0) ;
                            ListAnnoces.actulitesList.insert(0,actualiteElement) ;
                            showValidationCredentials(
                              context,
                              'Ajoutée avec succées',
                              'Votre  atualité a été ajouée avec succées.',
                              Icons.check,
                              const Color(0xFF1F7774),
                              const Color(0xFF414141),
                              const Color(0xFF414141),
                              const Color(0xFF1F7774),'/listVentes'
                              //'/login'
                            );
                            _isDialogShown = true;

                          }

                          else if(state is VenteErrorState){
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