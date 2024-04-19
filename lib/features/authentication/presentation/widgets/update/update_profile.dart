
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/update/bloc/update_bloc.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/update/bloc/update_event.dart';
import 'package:pfechotranasmartvillage/features/authentication/presentation/widgets/update/bloc/update_state.dart';
import '../../../../../core/connection_management.dart';
import '../../../../../core/dependencies_injection.dart';
import '../../../../../core/pop_up_messages.dart';
import '../../../bloc/user_bloc.dart';
import '../../../bloc/user_event.dart';
import '../../../bloc/user_state.dart';
import '../../../domain/model/user.dart';
import '../subwidgets/button_update.dart';

class UpdteProfile extends StatelessWidget {
  const UpdteProfile({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    initDependencies();

    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider<UserBloc>(
          create: (context) => getIt<UserBloc>()..add(UserInfoEventInitial()),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => getIt<SignupBloc>(),
        ),
        BlocProvider<UpdateBloc>(
          create: (context) => getIt<UpdateBloc>(),
        ),
      ], child: UpdateWidget()),
    );
  }
}

class UpdateWidget extends StatefulWidget {
  const UpdateWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UpdateWidgetState();
  }
}

class _UpdateWidgetState extends State<UpdateWidget> {
  final fullNameController = TextEditingController();
  final establishmentController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();
  final posteController = TextEditingController();
  final cinController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    establishmentController.dispose();
    emailController.dispose();
    addressController.dispose();
    telephoneController.dispose();
    posteController.dispose();
    cinController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Expanded(flex: 1, child: _TopPortion()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccessState) {
                            fullNameController.text = state.userObject.username;
                            emailController.text = state.userObject.email;
                            telephoneController.text =
                                state.userObject.telephone;
                            establishmentController.text =
                                state.userObject.establishment;

                            cinController.text = state.userObject.cin;
                            posteController.text = state.userObject.post;
                            passwordController.text = state.userObject.password;

                            return Column(
                              children: [
                                TextFieldWidget(
                                  textStyle:
                                      const TextStyle(color: Color(0xff414141)),
                                  borderInput: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  borderStyle: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  controller: fullNameController,
                                  iconPrefix: const Icon(
                                    Icons.person_outline,
                                    color: Color(0xff414141),
                                  ),
                                  colorInputField: const Color(0xffffffff),
                                  keyboardtype: TextInputType.multiline,
                                  isTextObscure: false,
                                  //validator: (String? ) {  },
                                ),
                                TextFieldWidget(
                                    textStyle: const TextStyle(
                                        color: Color(0xff414141)),
                                    borderInput: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    borderStyle: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    iconPrefix: const Icon(Icons.email_outlined,
                                        color: Color(0xff414141)),
                                    keyboardtype: TextInputType.multiline,
                                    controller: emailController,
                                    isTextObscure: false,
                                    //validator: (String? ) {  },
                                    colorInputField: const Color(0xffffffff)),
                                TextFieldWidget(
                                    textStyle: const TextStyle(
                                        color: Color(0xff414141)),
                                    borderInput: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    borderStyle: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    iconPrefix: const Icon(
                                        Icons.phone_enabled_outlined,
                                        color: Color(0xff414141)),
                                    keyboardtype: TextInputType.multiline,
                                    controller: telephoneController,
                                    isTextObscure: false,
                                    //validator: (String? ) {  },
                                    colorInputField: const Color(0xffffffff)),
                                TextFieldWidget(
                                    textStyle: const TextStyle(
                                        color: Color(0xff414141)),
                                    borderInput: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    borderStyle: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    iconPrefix: const Icon(Icons.business,
                                        color: Color(0xff414141)),
                                    keyboardtype: TextInputType.multiline,
                                    controller: cinController,
                                    isTextObscure: false,
                                    //validator: (String? ) {  },
                                    colorInputField: const Color(0xffffffff)),
                                TextFieldWidget(
                                    textStyle: const TextStyle(
                                        color: Color(0xff414141)),
                                    borderInput: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    borderStyle: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    iconPrefix: const Icon(Icons.work_outline,
                                        color: Color(0xff414141)),
                                    keyboardtype: TextInputType.multiline,
                                    controller: posteController,
                                    isTextObscure: false,
                                    //validator: (String? ) {  },
                                    colorInputField: const Color(0xffffffff)),
                                TextFieldWidget(
                                    textStyle: const TextStyle(
                                        color: Color(0xff414141)),
                                    borderInput: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    borderStyle: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    iconPrefix: const Icon(Icons.credit_card,
                                        color: Color(0xff414141)),
                                    keyboardtype: TextInputType.multiline,
                                    controller: establishmentController,
                                    isTextObscure: false,
                                    //validator: (String? ) {  },
                                    colorInputField: const Color(0xffffffff)),
                                TextFieldWidget(
                                    textStyle: const TextStyle(
                                        color: Color(0xff414141)),
                                    borderInput: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    borderStyle: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    iconPrefix: const Icon(Icons.lock_outlined,
                                        color: Color(0xff414141)),
                                    keyboardtype: TextInputType.multiline,
                                    controller: passwordController,
                                    isTextObscure: false,
                                    //validator: (String? ) {  },
                                    colorInputField: const Color(0xffffffff)),
                              ],
                            );
                          }
                          return const SizedBox
                              .shrink(); // Example: Returns an empty SizedBox if not in UserSuccessState
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const SizedBox(width: 16.0),

                          SizedBox(
                            width: 150,
                            child: ButtonUpdate(onTap: () async{
                              bool isConnected = await checkConnection(); // Vérifier la connexion

                              if (!isConnected) {
                                showValidationCredentials(
                                  context,
                                  'Échec de la connexion',
                                  'Veuillez vérifier votre connexion Internet et réessayer.',
                                  Icons.error_outline,
                                  const Color(0xff7FB77E),
                                  //'/login'
                                );                              } else {
                                bool shouldUpdate = await showValidationDialog(context, Icons.check, 'Voulez-vous sauvegarder les changements?');
                                if (shouldUpdate) {
                                  BlocProvider.of<UpdateBloc>(context).add(UpdateUserEvent(
                                    fullNameController.text,
                                    User(
                                      username: fullNameController.text,
                                      password: passwordController.text,
                                      email: emailController.text,
                                      telephone: telephoneController.text,
                                      establishment: establishmentController.text,
                                      post: posteController.text,
                                      cin: cinController.text,
                                    ),
                                  ));
                                }
                              }
                            }, buttonContent: 'Enregistrer', colorButton: const Color(0xFF7FB77E),),
                          ),
                          const SizedBox(width: 16,),
                          SizedBox(
                            width: 150,
                            child: ButtonUpdate(onTap: () {
                              Navigator.pushNamed(context, '/profileInfo');
                            }, buttonContent: 'Annuler', colorButton: const Color(0xFFF28F8F),),
                          )

                        ],
                      ),
                      MultiBlocListener(
                        listeners: [
                          BlocListener<UpdateBloc, UpdateUserState>(
                            listener: (context, state) {
                              if (state is UpdateErrorState) {
                                showValidationCredentials(
                                    context,
                                    'Les données ne sont pas modifiées',
                                    'erruer',
                                    Icons.error_outline,
                                    const Color(0xff7FB77E),
                                    //'/login'
                                );
                              } else if (state is UpdateSuccessState) {
                                Navigator.pushNamed(context, '/profileInfo');
                              } else {
                                debugPrint('There is some exception error');
                              }
                            },
                          ),], child: const Text(''),),
                      //const _ProfileInfoRow()
                    ],
                  ),
                ),
              ),
            ),
            const ButtonNavigationBar()
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF7FB77E), Color(0xFF7FB77E)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    //color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/proile_picture.png')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
