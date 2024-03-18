import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class UpdteProfile extends StatefulWidget {
  UpdteProfile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UpdteProfileState();
  }
}

class _UpdteProfileState extends State<UpdteProfile> {
  final inputController1 = TextEditingController();
  final inputController2 = TextEditingController();
  final inputController3 = TextEditingController();
  final inputController4 = TextEditingController();
  final inputController5 = TextEditingController();
  final inputController6 = TextEditingController();

  @override
  void dispose() {
    inputController1.dispose();
    inputController2.dispose();
    inputController3.dispose();
    inputController4.dispose();
    inputController5.dispose();
    inputController6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 1, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    TextFieldWidget(
                      textStyle: TextStyle(color: Color(0xff414141)),
                      borderInput: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      borderStyle: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      controller: inputController1,
                      iconPrefix: Icon(
                        Icons.person_outline,
                        color: Color(0xff414141),
                      ),
                      colorInputField: const Color(0xffffffff),
                      keyboardtype: TextInputType.multiline,
                      isTextObscure: false,
                      //validator: (String? ) {  },
                    ),
                    TextFieldWidget(
                        textStyle: TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix:
                            Icon(Icons.edit_outlined, color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: inputController2,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: Icon(Icons.power_settings_new_rounded,
                            color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: inputController3,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: Icon(Icons.email_outlined,
                            color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: inputController4,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: Icon(Icons.phone, color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: inputController5,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix:
                            Icon(Icons.work_outline, color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: inputController6,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'follow',
                            elevation: 0,
                            backgroundColor: const Color(0xff3BC4BF),
                            foregroundColor: const Color(0xffffffff),
                            label: const Text("Enregistrer"),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        SizedBox(
                          width: 150,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'Verify',
                            elevation: 0,
                            foregroundColor: const Color(0xffffffff),
                            backgroundColor: const Color(0xffF28F8F),
                            label: const Text("Anuuler"),
                            //icon: const Icon(Icons.message_outlined),
                          ),
                        ),
                      ],
                    ),

                    //const _ProfileInfoRow()
                  ],
                ),
              ),
            ),
          ),
          const ButtonNavigationBar()
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xffA7C352), Color(0xffA7C352)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    //color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/proile_picture.png')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      /*decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),*/
                      child: Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
