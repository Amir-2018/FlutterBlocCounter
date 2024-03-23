import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/connection_bar.dart';
import '../../../../../core/connection_management.dart';
import '../../../../../core/dependencies_injection.dart';
import '../../../domain/model/user.dart';
import '../subwidgets/saveWidgetButton.dart';
import '../subwidgets/textFieldWidget.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_event.dart';
import 'bloc/signup_state.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});
  @override
  Widget build(BuildContext context) {
    initDependencies();
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF2B6353),
      ),*/
      body: MultiBlocProvider(providers: [
        BlocProvider<SignupBloc>(
          create: (context) => getIt<SignupBloc>(
              //getIt<CreateUseCase>()
              ),
        ),
      ], child: MySignup()),
    );
  }
}

class MySignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySignupState();
  }
}

class _MySignupState extends State<MySignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();
  final establishmentController = TextEditingController();
  final postController = TextEditingController();
  final cinContrcinoller = TextEditingController();
  // To controlle the scroll of the comumn
  final ScrollController scrollcontroller = new ScrollController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    establishmentController.dispose();
    postController.dispose();
    cinContrcinoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: const Color(0xFF1F7774),
        foregroundColor: const Color(0xFFFFFFFF),
      ),*/
      body: Stack(
        children: [
          //Container(
          //  color: const Color(0xFF1F7774),
          //),
          Container(
              color: const Color(0xFF1F7774),
              //.withOpacity(0.7), // Adjust color and opacity as needed
              constraints: const BoxConstraints.expand()),
          Container(
            child: Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Container(
                        child: ClipRect(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              const Image(
                                  image: AssetImage('assets/signup.png')),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Créer votre compte',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F7774)),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null || value.isEmpty) {
                                      return "Nom d'utilisateur est non valide";
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: usernameController,
                                  isTextObscure: false,
                                  placeholder: "Nom d'utilisateur",
                                  iconPrefix: const Icon(Icons.person_outline),
                                  colorInputField: const Color(0xFFD9D9D9)),

                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null || value.isEmpty) {
                                      return 'Champ email est vide';
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return 'Entrer un email valide';
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: emailController,
                                  isTextObscure: false,
                                  placeholder: 'Email',
                                  iconPrefix: Icon(Icons.email_outlined),
                                  colorInputField: Color(0xFFD9D9D9)),

                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 8) {
                                      return 'Entrer un nombre de  telephone valide ';
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  keyboardtype: TextInputType.number,
                                  controller: telephoneController,
                                  isTextObscure: true,
                                  placeholder: 'Telephone',
                                  iconPrefix: const Icon(Icons.phone_outlined),
                                  colorInputField: const Color(0xFFD9D9D9)),

                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null || value.isEmpty) {
                                      return "Nom d'établissement est non valide";
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: establishmentController,
                                  isTextObscure: false,
                                  placeholder: "Etablissement",
                                  iconPrefix: const Icon(Icons.badge_outlined),
                                  colorInputField: const Color(0xFFD9D9D9)),

                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null || value.isEmpty) {
                                      return 'Nom de poste est non valide';
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: postController,
                                  isTextObscure: false,
                                  placeholder: "Poste",
                                  iconPrefix: const Icon(Icons.work_outline),
                                  colorInputField: const Color(0xFFD9D9D9)),

                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 8) {
                                      return 'Cin est non valide';
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  keyboardtype: TextInputType.number,
                                  controller: cinContrcinoller,
                                  isTextObscure: false,
                                  placeholder: "Cin",
                                  iconPrefix: const Icon(Icons.person),
                                  colorInputField: const Color(0xFFD9D9D9)),

                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 8) {
                                      return 'Mot de passe  est non valide';
                                    }
                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  keyboardtype: TextInputType.number,
                                  controller: passwordController,
                                  isTextObscure: false,
                                  placeholder: "Mot de passe",
                                  iconPrefix: const Icon(Icons.person),
                                  colorInputField: const Color(0xFFD9D9D9)),

                              SaveWidgetButon(
                                buttonContent: 'Enregistrer',
                                onTap: () async {
                                  bool isConnected =
                                      await checkConnection(); // Vérifier la connexion

                                  if (!isConnected) {
                                    showConnectionFailedPopup(context);
                                  } else {
                                    if ((_formKey.currentState!).validate()) {
                                      //const snackBar = SnackBar(content: Text('Valid'));
                                      //ScaffoldMessenger.of(context)
                                      //.showSnackBar(snackBar);
                                      BlocProvider.of<SignupBloc>(context)
                                          .add(CreateUserEvent(User(
                                        // id : 3,
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        email: emailController.text,
                                        telephone: telephoneController.text,
                                        establishment:
                                            establishmentController.text,
                                        post: postController.text,
                                        cin: cinContrcinoller.text,
                                      )));
                                    } else {
                                      debugPrint(
                                          "Les champs ne sont pas valides");
                                    }
                                  }
                                },
                              ),
                              // The blockBuildr will manage the state right here
                              BlocBuilder<SignupBloc, SignupUserState>(
                                  builder: (context, state) {
                                if (state is SignupErrorState) {
                                  return Text(state.errormessage,
                                      style:
                                          const TextStyle(color: Colors.red));
                                } else if (state is SignupSuccessState) {
                                  return Text(state.successMessage,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 77, 86, 78)));
                                } else {
                                  return Container();
                                }
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                //padding : EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0) ,
                                //margin: EdgeInsets.symmetric(horizontal: 90.0,vertical: 0.0),
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'avez voud déja un compte ? ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Connexion',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Color(0xFFFEBE50)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
