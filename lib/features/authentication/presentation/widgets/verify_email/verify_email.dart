
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependencies_injection.dart';
import '../login/bloc/login_bloc.dart';
import '../subwidgets/saveWidgetButton.dart';
import '../subwidgets/textFieldWidget.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});
  @override
  Widget build(BuildContext context) {
    initDependencies();
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF2B6353),
      ),*/
      body: MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(
              //getIt<CreateUseCase>()
              ),
        ),
      ], child: Login()),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() {
    return _VerifyEmailState();
  }
}

class _VerifyEmailState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: const Color(0xFF1F7774),
        foregroundColor: const Color(0xFFFFFFFF),
      ), */
      body: Stack(
        children: [
          Container(
              color: const Color(0xFF1F7774),
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
                      color: const Color(0xFF1F7774),
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
                              const Image(
                                  image: AssetImage('assets/verifyemail.png')),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Récupération',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F7774)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: usernameController,
                                  isTextObscure: false,
                                  placeholder: "Email",
                                  iconPrefix: const Icon(Icons.email_outlined),
                                  colorInputField: const Color(0xFFD9D9D9)),
                              const SizedBox(
                                height: 10,
                              ),
                              SaveWidgetButon(
                                buttonContent: 'Connexion',
                                onTap: () {
                                  if ((_formKey.currentState!).validate()) {
                                    Navigator.pushNamed(
                                        context, '/changePassword');

                                    /*BlocProvider.of<LoginBloc>(context).add(
                                        SubmitUserEvent(AuthUser(
                                            // id : 3,
                                            username: usernameController.text,
                                            password:
                                                passwordController.text)));*/
                                  }
                                },
                              ),
                              BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                if (state is LoginErrorState) {
                                  return Text(state.errormessage,
                                      style:
                                          const TextStyle(color: Colors.red));
                                } else if (state is LoginSuccessState) {
                                  return Text(state.successMessage,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 77, 86, 78)));
                                } else {
                                  return Container();
                                }
                              }),
                              const SizedBox(
                                height: 15,
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
