/*import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/saveWidgetButton.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});
  @override
  State<VerifyCode> createState() {
    return _VerifyCodeState();
  }
}

class _VerifyCodeState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: const Text('Chotrana'),
          backgroundColor: const Color(0xFF2B6353),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        body: Stack(children: [
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
                    const Image(image: AssetImage('verifyEmail.png')),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        isTextObscure: true,
                        placeholder: 'Code Verification',
                        iconPrefix: Icon(Icons.lock_outline),
                        colorInputField: Color(0xFFD9D9D9)),
                    const SizedBox(
                      height: 20,
                    ),
                    SaveWidgetButon(
                      buttonContent: 'Verify',
                      onTap: () {
                        Navigator.pushNamed(context, '/changePassword');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
*/