/*import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  BackgroundWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Container(
          color: const Color(0xFF2B6353),
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
                  Container(
                    width: 54,
                    height: 8,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xFFD9D9D9)),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Image(image: AssetImage('assets/login_image.png')),
                  const Text(
                    'Getting Started',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Login for explore or continue',
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                      isTextObscure: false,
                      placeholder: 'Email',
                      iconPrefix: Icon(Icons.email_outlined),
                      colorInputField: Color(0xFFD9D9D9)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                      isTextObscure: true,
                      placeholder: 'Password',
                      iconPrefix: Icon(Icons.lock_outline),
                      colorInputField: Color(0xFFD9D9D9)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Forgot password',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFF36060),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SaveWidgetButon(
                    buttonContent: 'Login',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    //padding : EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0) ,
                    //margin: EdgeInsets.symmetric(horizontal: 90.0,vertical: 0.0),
                    decoration: BoxDecoration(),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account ? ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Sign Up here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF2B6353)),
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
    );
  }
}
*/