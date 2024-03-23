import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/button_navigation_bar.dart';
import 'package:bloc_app/features/authentication/presentation/widgets/subwidgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class UpdteProfile extends StatefulWidget {
  const UpdteProfile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UpdteProfileState();
  }
}

class _UpdteProfileState extends State<UpdteProfile> {
  final fullNameController = TextEditingController(text: 'Richie Lorie');
  final descriptionController =
      TextEditingController(text: 'I am jhon and i am software ingeneer');
  final addressController =
      TextEditingController(text: 'Sfax sakiet ezzit 2024');
  final emailController =
      TextEditingController(text: 'Jhon.Doe@actia-engineering.tn');
  final telephoneController = TextEditingController(text: '+216 412 325 698');
  final posteController = TextEditingController(text: 'Technical lead');

  @override
  void dispose() {
    fullNameController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    addressController.dispose();
    telephoneController.dispose();
    posteController.dispose();
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
                      textStyle: const TextStyle(color: Color(0xff414141)),
                      borderInput: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      borderStyle: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      controller: fullNameController,
                      iconPrefix: const Icon(
                        Icons.person_outline,
                        color: Color(0xff414141),
                      ),
                      colorInputField: const Color(0xffffffff),
                      keyboardtype: TextInputType.multiline,
                      isTextObscure: false,
                      //validator: (String? ) {  },
                    ),
                    TextFieldWidget(
                        textStyle: const TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: const Icon(Icons.edit_outlined,
                            color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: descriptionController,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: const TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: const Icon(Icons.power_settings_new_rounded,
                            color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: emailController,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: const TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: const Icon(Icons.email_outlined,
                            color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: addressController,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: const TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix:
                            const Icon(Icons.phone, color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: telephoneController,
                        isTextObscure: false,
                        //validator: (String? ) {  },
                        colorInputField: const Color(0xffffffff)),
                    TextFieldWidget(
                        textStyle: const TextStyle(color: Color(0xff414141)),
                        borderInput: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        borderStyle: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        iconPrefix: const Icon(Icons.work_outline,
                            color: Color(0xff414141)),
                        keyboardtype: TextInputType.multiline,
                        controller: emailController,
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
                            backgroundColor: const Color(0xFF1F7774),
                            foregroundColor: const Color(0xffffffff),
                            label: const Text(
                              "Enregistrer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        SizedBox(
                          width: 150,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
                            heroTag: 'Verify',
                            elevation: 0,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors
                                .redAccent, // Adjusted to red for cancellation
                            label: const Text(
                              "Annuler",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
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
                  colors: [Color(0xFF1F7774), Color(0xFF1F7774)]),
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
                      child: const Icon(
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
