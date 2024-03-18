import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: const Color(0xFF2B6353),
        foregroundColor: const Color(0xFFFFFFFF),
      ),*/
      body: Form(
        key: _formKey,
        child: Stack(children: [
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
          Container(
            //color: const Color(0xFF2B6353),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/login_image.png')),
                    const SizedBox(
                      height: 50,
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
                            return 'Entrer un mot de passe valide ';
                          }
                          return null;
                        },
                        //borderRadius: BorderRadius.circular(10.0),
                        borderInput: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        controller: passwordController,
                        isTextObscure: true,
                        placeholder: 'Password',
                        iconPrefix: Icon(Icons.lock_outline),
                        colorInputField: Color(0xFFD9D9D9)),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/verifyEmail');
                      },
                      child: const Text(
                        'Forgot Password ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SaveWidgetButon(
                        buttonContent: 'Connexion',
                        onTap: () {
                          if ((_formKey.currentState!).validate()) {
                            Navigator.pushNamed(context, '/profileinfo');
                          } else {
                            debugPrint("Not connected");
                          }
                        }),
                    const SizedBox(
                      height: 15,
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
                            child: Text(
                              'Enregistrer',
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
          ),
        ]),
      ),
    );
  }
}
