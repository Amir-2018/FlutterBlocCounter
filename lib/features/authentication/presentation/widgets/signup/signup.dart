import 'package:bloc_app/features/authentication/domain/implementation/user_repository_implementation.dart';
import 'package:bloc_app/features/authentication/domain/model/user.dart';
import 'package:bloc_app/features/authentication/presentation/bloc/formvalidation_bloc.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_bloc.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_event.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/signup/bloc/signup_state.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class SignupWidget extends StatelessWidget {
  SignupWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Chotrana'),
        backgroundColor: const Color(0xFF2B6353),
        foregroundColor: const Color(0xFFFFFFFF),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(UserImplementation()),
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
      body: Form(
        key: _formKey,
        child: Center(
          child: Stack(children: [
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
              padding: EdgeInsets.all(10.0),
              //color: const Color(0xFF2B6353),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Image(image: AssetImage('signup.png')),
                      const SizedBox(
                        height: 20,
                      ),

                      TextFieldWidget(
                          validator: (value) {
                            debugPrint('I bring the value $value');
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid full name';
                            }

                            return null;
                          },
                          controller: nameController,
                          isTextObscure: false,
                          placeholder: 'Full Name',
                          iconPrefix: Icon(Icons.email),
                          colorInputField: Color(0xFFD9D9D9)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          validator: (value) {
                            debugPrint('I bring the value $value');
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          controller: usernameController,
                          isTextObscure: false,
                          placeholder: 'Email',
                          iconPrefix: Icon(Icons.email_outlined),
                          colorInputField: Color(0xFFD9D9D9)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          validator: (value) {
                            debugPrint('I bring the value $value');
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return 'Please enter a valid password';
                            }

                            return null;
                          },
                          controller: emailController,
                          isTextObscure: true,
                          placeholder: 'Password',
                          iconPrefix: const Icon(Icons.lock_outline),
                          colorInputField: const Color(0xFFD9D9D9)),
                      const SizedBox(
                        height: 20,
                      ),

                      SaveWidgetButon(
                        buttonContent: 'Sign Up',
                        onTap: () {
                          if ((_formKey.currentState!).validate()) {
                            const snackBar = SnackBar(content: Text('Valid'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            BlocProvider.of<SignupBloc>(context).add(
                                CreateUserEvent(User(
                                    id: 100,
                                    name: nameController.text,
                                    username: usernameController.text,
                                    email: emailController.text)));
                          } else {
                            debugPrint("test");
                          }
                        },
                      ),

                      const SizedBox(
                        height: 15,
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
                      Container(
                        //padding : EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0) ,
                        //margin: EdgeInsets.symmetric(horizontal: 90.0,vertical: 0.0),
                        decoration: BoxDecoration(),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Did you have an account ? ',
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
                                'Login',
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
      ),
    );
  }
}
