import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/connection_management.dart';
import '../../../../../core/dependencies_injection.dart';
import '../../../../../core/pop_up_messages.dart';
import '../../../domain/model/auth_user.dart';
import '../subwidgets/saveWidgetButton.dart';
import '../subwidgets/textFieldWidget.dart';
import 'bloc/login_bloc.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});
  @override
  Widget build(BuildContext context) {
    initDependencies();
    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
      ], child: Login()),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext bigcontext) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: const Color(0xFF7FB77E),
              //.withOpacity(0.7), // Adjust color and opacity as needed
              constraints: const BoxConstraints.expand()),
          Positioned(
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
                  child: Stack(children: [
                    Container(
                      color: const Color(0xFF7FB77E),
                    ),
                    Column(
                      children: [
                        Expanded(flex: 0, child: Container()),
                        Expanded(
                            flex: 20,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0))),
                            )),
                      ],
                    ),
                    Container(
                      //color: const Color(0xFF2B6353),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Container(
                                  child: SvgPicture.asset('assets/login_image.svg')),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Connexion',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7FB77E)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 3) {
                                      return "Nom d'utilisateur est invalide";
                                    }

                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: usernameController,
                                  isTextObscure: false,
                                  placeholder: "Nom d'utilisateur",
                                  iconPrefix: const Icon(Icons.person_outlined,color: Colors.black38,),
                                  colorInputField: const Color(0xFFD9D9D9)),
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
                                  controller: passwordController,
                                  isTextObscure: true,
                                  placeholder: 'Mot de passe',
                                  iconPrefix: const Icon(Icons.lock_outline,color: Colors.black38),
                                  colorInputField: const Color(0xFFD9D9D9)),
                              GestureDetector(
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
                                      const Color(0xFF1F7774),null


                                      //'/login'
                                    );
                                  } else {
                                    //if ((_formKey.currentState!).validate()) {
                                    Navigator.pushNamed(
                                        context, '/verifyEmail');
                                    // }
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          25), // Applying padding only to the right side

                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Mot de passe oublié ?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color(0xFF7FB77E), // Changing color to a typical link color
                                        //  : TextDecoration
                                        //.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SaveWidgetButon(
                                buttonContent: 'Connexion',
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
                                      const Color(0xFF1F7774),null

                                      //'/login'
                                    );
                                  } else
                                  {
                                    if ((_formKey.currentState!).validate()) {

                                      BlocProvider.of<LoginBloc>(context).add(
                                          SubmitUserEvent(AuthUser(
                                              // id : 3,
                                              username: usernameController.text,
                                              password:
                                                  passwordController.text)));
                                    }
                                 }
                                },
                              ),
                              MultiBlocListener(
                              listeners: [
                                BlocListener<LoginBloc, LoginState>(
                                  listener: (context, state) {
                                    if (state is LoginErrorState) {
                                      showValidationCredentials(
                                          context,
                                          'Données erronées',
                                          'Merci de les vérifier.',
                                          Icons.error_outline,
                                        const Color(0xFFFF0000),
                                        const Color(0xFFFF0000),
                                        const Color(0xFF414141),
                                        const Color(0xFF1F7774),null

                                        //'/login'
                                      );
                                    } else if (state is LoginSuccessState) {
                                      Navigator.pushNamed(context, '/services');
                                    } else {
                                      debugPrint('There is some exception error');
                                    }
                                  },
                                ),], child: const Text(''),),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Créer un compte? ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: const Text(
                                      'Enregistrer',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Color(0xFFFEBE50)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
