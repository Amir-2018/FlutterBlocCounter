/*import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});
  @override
  State<ChangePasswordWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<ChangePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: const Text('Chotrana'),
          backgroundColor: const Color(0xFF2B6353),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        body: Center(
          child: Stack(children: [
            Container(
                //color: const Color(0xFF2B6353),
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
                      const Image(image: AssetImage('login_image.png')),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          isTextObscure: true,
                          placeholder: 'New Password',
                          iconPrefix: Icon(Icons.lock_outline),
                          colorInputField: Color(0xFFD9D9D9)),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextFieldWidget(
                          isTextObscure: true,
                          placeholder: 'Confirm Password',
                          iconPrefix: Icon(Icons.lock_outline),
                          colorInputField: Color(0xFFD9D9D9)),
                      const SizedBox(
                        height: 20,
                      ),
                      SaveWidgetButon(buttonContent: 'Apply', onTap: () {}),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
*/