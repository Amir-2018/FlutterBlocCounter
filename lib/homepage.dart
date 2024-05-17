import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';



class HabitApp extends StatelessWidget {
  const HabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
   OnboardingScreen();

  }
}


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/mode') ;
  }//

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      skipStyle: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17)),
          foregroundColor: MaterialStateProperty.all(Colors.redAccent)),
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [

        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SvgPicture.asset(
                    'assets/home/event.svg',
                    fit: BoxFit.cover, // Ensure the SVG covers the entire container
                  ),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SvgPicture.asset(
                    'assets/home/event2.svg',
                    fit: BoxFit.cover, // Ensure the SVG covers the entire container
                  ),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SvgPicture.asset(
                    'assets/home/event3.svg',
                    fit: BoxFit.cover, // Ensure the SVG covers the entire container
                  ),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SvgPicture.asset(
                    'assets/home/event4.svg',
                    fit: BoxFit.cover, // Ensure the SVG covers the entire container
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      // onChange: (val) {},
      skip: const Text('Ignorer', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(
        Icons.arrow_forward,
      ),
      done: const Text('Commencer',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 127, 183, 126))),
      onDone: () => _onIntroEnd(context),
      nextStyle: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all(Color.fromARGB(255, 127, 183, 126))),
      dotsDecorator: const DotsDecorator(
        size: Size.square(10),
        activeColor: Color.fromARGB(255, 127, 183, 126),
        activeSize: Size.square(17),
      ),
    );
  }
}