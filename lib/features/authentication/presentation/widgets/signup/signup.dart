
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/dependencies_injection.dart';
import '../../../domain/model/user.dart';
import '../../../domain/usecases/create_user_usecase.dart';
import '../../bloc/signup_bloc.dart';
import '../../bloc/signup_event.dart';
import '../../bloc/signup_state.dart';
import '../subwidgets/saveWidgetButton.dart';
import '../subwidgets/textFieldWidget.dart';

class SignupWidget extends StatelessWidget {
    const SignupWidget({super.key});
  @override
  Widget build(BuildContext context) {
    initDependencies() ;
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
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            color: const Color(0xFFA7C352),
          ),
          Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 9,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0))),
                  )),
            ],
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  const Image(image: AssetImage('assets/signup.png')),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFieldWidget(
                      validator: (value) {
                        debugPrint('I bring the value $value');
                        if (value == null || value.isEmpty) {
                          return 'Nom est non valide';
                        }
                        return null;
                      },
                      borderInput:  OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      controller: nameController,
                      isTextObscure: false,
                      placeholder: 'Nom et Prenom',
                      iconPrefix: const Icon(Icons.person),
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
                      borderInput:  OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      controller: usernameController,
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
                          return 'Entrer un mot de passe valide ';
                        }
                        return null;
                      },
                      borderInput:  OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      controller: emailController,
                      isTextObscure: true,
                      placeholder: 'Mot de passe',
                      iconPrefix: const Icon(Icons.lock_outline),
                      colorInputField: const Color(0xFFD9D9D9)),

                  SaveWidgetButon(
                    buttonContent: 'Enregistrer',
                    onTap: () {
                      if ((_formKey.currentState!).validate()) {
                        //const snackBar = SnackBar(content: Text('Valid'));
                        //ScaffoldMessenger.of(context)
                        //.showSnackBar(snackBar);
                        BlocProvider.of<SignupBloc>(context).add(
                            CreateUserEvent(User(
                                // id : 3,
                                name: nameController.text,
                                username: usernameController.text,
                                email: emailController.text)));
                      } else {
                        debugPrint("Les champs ne sont pas valides");
                      }
                    },
                  ),
                  // The blockBuildr will manage the state right here
                  BlocBuilder<SignupBloc, SignupUserState>(
                      builder: (context, state) {
                        if (state is SignupErrorState) {
                          return Text(state.errormessage,
                              style: const TextStyle(color: Colors.red));
                        } else if (state is SignupSuccessState) {

                          return Text(state.successMessage,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 77, 86, 78)));
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
                ],
              ),
            ),
          ),
        ],

      ),
        );
  }
}
