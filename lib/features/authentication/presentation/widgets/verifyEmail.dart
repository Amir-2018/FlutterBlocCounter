import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  VerifyEmail({super.key});
  @override
  State<VerifyEmail> createState() {
    return _VerifyEmailState();
  }
}

class _VerifyEmailState extends State<VerifyEmail> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        //title: const Text('Chotrana'),
        backgroundColor: const Color(0xFF2B6353),
        foregroundColor: const Color(0xFFFFFFFF),
      ),*/
      body: Center(
        child: Stack(children: [
          Container(
              //color: const Color(0xFF2B6353),
              ),
          Container(
            color: const Color(0xFFA7C352),
          ),
          Form(
            child: Column(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage('assets/verifyemail.png')),
                      const SizedBox(
                        height: 20,
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
                          controller: emailController,
                          isTextObscure: false,
                          placeholder: 'Email',
                          iconPrefix: Icon(Icons.email_outlined),
                          colorInputField: Color(0xFFD9D9D9)),
                      const SizedBox(
                        height: 20,
                      ),
                      SaveWidgetButon(
                        buttonContent: 'Send',
                        onTap: () {
                          const snackBar = SnackBar(
                            content: Text(
                                'Un nouveau mot de passe est envoyé à votre email'),
                          );
                          if ((_formKey.currentState!).validate()) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            debugPrint('email ets invalide');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
