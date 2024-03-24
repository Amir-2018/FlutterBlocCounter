import 'package:bloc_app/core/connection_bar.dart';
import 'package:bloc_app/core/connection_management.dart';
import 'package:bloc_app/core/dependencies_injection.dart';
import 'package:bloc_app/core/pop_up_messages.dart';
import 'package:bloc_app/features/authentication/bloc/user_bloc.dart';
import 'package:bloc_app/features/authentication/bloc/user_event.dart';
import 'package:bloc_app/features/authentication/bloc/user_state.dart';
import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_event.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                    iconPrefix: const Icon(Icons.work_outline,
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
                                    iconPrefix: const Icon(Icons.business,
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
                          // Handle other states or return null if no UI should be shown
                          return SizedBox
                              .shrink(); // Example: Returns an empty SizedBox if not in UserSuccessState
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: FloatingActionButton.extended(
                              onPressed: () async {
                                bool isConnected =
                                    await checkConnection(); // Check connection
                                if (!isConnected) {
                                  showConnectionFailedPopup(context);
                                } else {
                                  bool confirmation = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: const Color(0xFF1F7774),
                                              width: 2.0),
                                        ),
                                        backgroundColor: Colors.white,
                                        elevation: 5,
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.warning,
                                                color: const Color(0xFF1F7774),
                                                size: 50.0,
                                              ),
                                              const SizedBox(height: 15.0),
                                              Text(
                                                "Confirmation",
                                                style: const TextStyle(
                                                  color: Color(0xFF1F7774),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "Sauvegarder la modification?",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color(0xFF1F7774),
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              const SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: const Color(
                                                          0xFF1F7774),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20.0,
                                                          vertical: 10.0),
                                                      child: const Text(
                                                        'Non',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: const Color(
                                                          0xFF1F7774),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        bool isConnected =
                                                            await checkConnection(); // Vérifier la connexion

                                                        if (!isConnected) {
                                                          showConnectionFailedPopup(
                                                              context);
                                                        } else {
                                                          if ((_formKey
                                                                  .currentState!)
                                                              .validate()) {
                                                            //const snackBar = SnackBar(content: Text('Valid'));
                                                            //ScaffoldMessenger.of(context)
                                                            //.showSnackBar(snackBar);
                                                            var usernameController;
                                                            BlocProvider.of<
                                                                        SignupBloc>(
                                                                    context)
                                                                .add(
                                                                    CreateUserEvent(
                                                                        User(
                                                              // id : 3,
                                                              username:
                                                                  usernameController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              telephone:
                                                                  telephoneController
                                                                      .text,
                                                              establishment:
                                                                  establishmentController
                                                                      .text,
                                                              post:
                                                                  posteController
                                                                      .text,
                                                              cin: cinController
                                                                  .text,
                                                            )));
                                                          }
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 10.0),
                                                        child: const Text(
                                                          'Oui',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },

                              //showValidationPopup(context)
                              heroTag: 'follow',
                              elevation: 0,
                              backgroundColor: const Color(0xFF1F7774),
                              foregroundColor: const Color(0xffffffff),
                              label: const Text(
                                "Enregistrer",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          SizedBox(
                            width: 150,
                            child: FloatingActionButton.extended(
                              onPressed: () async {
                                bool isConnected =
                                    await checkConnection(); // Vérifier la connexion

                                if (!isConnected) {
                                  showConnectionFailedPopup(context);
                                } else {
                                  Navigator.pushNamed(context, '/profileinfo');
                                }
                              },

                              heroTag: 'Verify',
                              elevation: 0,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors
                                  .redAccent, // Adjusted to red for cancellation
                              label: const Text(
                                "Annuler",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

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
                  colors: [Color(0xFF1F7774), Color(0xFF1F7774)]),
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
                      /*decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),*/
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
