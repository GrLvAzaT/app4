import 'package:app5/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app5/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(top: 50),
        child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 4;
              });
            },
            children: [
              buildPage(
                  //color: Color.fromARGB(255, 0, 255, 8),
                  urlImage: 'assets/Аватар.png',
                  titile: 'Instagram:',
                  subtitle: '@challenge_course'),
              buildPage(
                  //color: Colors.green.shade100,
                  urlImage: 'assets/Group 17.png',
                  titile: ' VK:',
                  subtitle: 'vk.com/challengeclubgcl'),
              buildPage(
                  //color: Colors.green.shade100,
                  urlImage: 'assets/Group 39.png',
                  titile: 'Поможем увидеть возможности',
                  subtitle:
                      'Мы знаем, что каждый способен достичь любого навыка и способен его развивать.'),
              buildPage(
                  //color: Colors.green.shade100,
                  urlImage: 'assets/Group 40.png',
                  titile: 'Учим достигать цели',
                  subtitle:
                      'Как ставить цель, как правильно подойти к ее реализации, какие инструменты можно применить?'),
              buildPage(
                  //color: Colors.green.shade100,
                  urlImage: 'assets/Group 41.png',
                  titile: 'Telegram:',
                  subtitle: 't.me/challengeclube'),
            ]),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  primary: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromRGBO(26, 25, 25, 1),
                  minimumSize: const Size.fromHeight(80)),
              child: const Text(
                'Start',
                style: TextStyle(
                    fontFamily: 'BebasNeue', color: Colors.white, fontSize: 28),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Color.fromRGBO(26, 25, 25, 1),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(4);
                      },
                      child: const Text(
                        'SKIP',
                        style: TextStyle(
                            fontFamily: 'BebasNeue',
                            color: Colors.white,
                            fontSize: 24),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 5,
                      effect: SlideEffect(
                          spacing: 5.0,
                          radius: 0.0,
                          dotWidth: 13.0,
                          dotHeight: 17.0,
                          paintStyle: PaintingStyle.fill,
                          strokeWidth: 1.5,
                          dotColor: Colors.black,
                          activeDotColor: Colors.white),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                            fontFamily: 'BebasNeue',
                            color: Colors.white,
                            fontSize: 24),
                      ))
                ],
              ),
            ),
    );
  }
}

Widget buildPage({
  //required Color color,
  required String urlImage,
  required String titile,
  required String subtitle,
}) =>
    Container(
      padding: const EdgeInsets.all(30),
      // color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(titile,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Balsamiq',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          Text(subtitle,
              style: TextStyle(
                fontFamily: 'Balsamiq',
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center),
        ],
      ),
    );
