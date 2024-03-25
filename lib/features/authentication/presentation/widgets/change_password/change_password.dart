import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/dependencies_injection.dart';
import '../login/bloc/login_bloc.dart';
import '../subwidgets/saveWidgetButton.dart';
import '../subwidgets/textFieldWidget.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});
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
      ], child: ChangePasswordWidget()),
    );
  }
}

class ChangePasswordWidget extends StatefulWidget {
  @override
  State<ChangePasswordWidget> createState() {
    return _ChangePasswordWidgetState();
  }
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
                                'Modifier Mot de Passe',
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
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 8) {
                                      return 'Mot de passe non valide';
                                    }

                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: newPasswordController,
                                  isTextObscure: true,
                                  placeholder: "Nouveau mot de passe ",
                                  iconPrefix: const Icon(Icons.lock_outline),
                                  colorInputField: const Color(0xFFD9D9D9)),
                              TextFieldWidget(
                                  validator: (value) {
                                    debugPrint('I bring the value $value');
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 8) {
                                      return 'Confirmer mot de passe';
                                    }

                                    return null;
                                  },
                                  borderInput: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  controller: confirmPasswordController,
                                  isTextObscure: true,
                                  placeholder: "Confirmer Mot de passe",
                                  iconPrefix: const Icon(Icons.lock_outline),
                                  colorInputField: const Color(0xFFD9D9D9)),
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
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 32,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
